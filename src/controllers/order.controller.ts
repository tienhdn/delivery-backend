import type { RequestHandler } from 'express';
import createHttpError from 'http-errors';
import type { OrderItemCreation, OrderStatus, Product } from '~/interfaces';
import { OrderItemModel, OrderModel, ProductModel, UserModel } from '~/models';
import {
  type CreateOrderBody,
  type UpdateOrderBody,
  type UpdateOrderParams,
} from '~/schemas';
import { response } from '~/utils';

const createOrder: RequestHandler<
  unknown,
  unknown,
  CreateOrderBody,
  unknown
> = async (req, res, next) => {
  const { customer_id, items } = req.body;

  try {
    const customerExists = await UserModel.findByPk(customer_id);
    // const deliveryExists = await UserModel.findByPk(delivery_id);
    if (!customerExists) {
      throw createHttpError(404, req.t('customer_not_found_exception'));
    }
    // if (!deliveryExists) {
    //   throw createHttpError(404, req.t('delivery_not_found_exception'));
    // }

    const productIds = items.map((item) => item.product_id);

    let products: Product[] = [];

    await Promise.all(
      productIds.map((id) =>
        ProductModel.findByPk(id).then((product) => {
          if (product) {
            return product.toJSON();
          }
          throw createHttpError(
            404,
            req.t('product_id_not_found_exception', { id }),
          );
        }),
      ),
    )
      .then((values) => {
        products = values as any;
      })
      .catch((error) => {
        throw error;
      });

    const combineProducts = products?.map((item) => {
      const found = items?.find((e) => e.product_id === item.id);
      return {
        ...item,
        quantity: found ? found.quantity : 0,
      };
    });

    const totalPrice = combineProducts.reduce((acc, currentValue) => {
      return acc + currentValue.price * currentValue.quantity;
    }, 0);

    const newOrder = await OrderModel.create({
      customer_id,
      total_price: totalPrice,
      // delivery_id,
      status: 'pending',
    });

    await Promise.all(
      combineProducts.map(async (item) => {
        const itemObj: OrderItemCreation = {
          product_id: item.id as number,
          quantity: item.quantity,
          price: item.price,
          import_price: item.import_price,
          order_id: newOrder?.id as number,
        };

        const product = await OrderItemModel.create(itemObj);
        if (product) {
          return product.toJSON();
        }
        throw createHttpError(
          404,
          req.t('product_id_not_found_exception', { id: item.id }),
        );
      }),
    )
      .then((values) => {
        return response(res, {
          status_code: 201,
        });
      })
      .catch((error) => {
        throw error;
      });
  } catch (error) {
    next(error);
  }
};

const updateOrder: RequestHandler<
  UpdateOrderParams,
  unknown,
  UpdateOrderBody,
  unknown
> = async (req, res, next) => {
  try {
    // @ts-ignore
    const uid = req.user.id;

    const orderId = req.params.id;

    const status = req.body.status as OrderStatus;

    const orderExists = await OrderModel.findByPk(orderId);

    if (!orderExists) {
      throw createHttpError(404, req.t('order_not_found_exception'));
    }

    const orderObj = orderExists.toJSON();

    if (orderObj.delivery_id && orderObj.delivery_id !== uid) {
      throw createHttpError(403, req.t('order_received_by_someone'));
    }

    await orderExists.update({ status: status });
    await orderExists.save();
    
    return response(res, {
      status_code: 200,
      data: orderExists.toJSON(),
    });
  } catch (error) {
    next(error);
  }
};

const getOrders: RequestHandler<unknown, unknown, unknown, unknown> = async (
  req,
  res,
  next,
) => {
  try {
    const orders = await OrderModel.findAll({
      attributes: { exclude: ['customer_id', 'delivery_id'] },
      include: [
        {
          model: UserModel,
          as: 'customer',
          attributes: ['id', 'fullname'],
        },
        {
          model: UserModel,
          as: 'delivery',
          attributes: ['id', 'fullname'],
        },
        {
          model: OrderItemModel,
          include: [
            {
              model: ProductModel,
            },
          ],
          attributes: { exclude: ['product_id', 'order_id'] },
        },
      ],
    });

    return response(res, {
      status_code: 200,
      data: orders,
    });
  } catch (error) {
    console.log(error);
    next(error);
  }
};

const getOrder: RequestHandler<unknown, unknown, unknown, unknown> = async (
  req,
  res,
  next,
) => {
  try {
  } catch (error) {
    next(error);
  }
};

const getPurchaseHistory: RequestHandler<
  unknown,
  unknown,
  unknown,
  unknown
> = async (req, res, next) => {
  // @ts-ignore
  const uid = req.user.id;

  try {
    const orders = await OrderModel.findAll({
      where: { customer_id: uid },
      attributes: { exclude: ['customer_id', 'delivery_id'] },
      include: [
        {
          model: OrderItemModel,
          include: [
            {
              model: ProductModel,
            },
          ],
          attributes: { exclude: ['product_id', 'order_id'] },
        },
      ],
    });

    return response(res, {
      status_code: 200,
      data: orders,
    });
  } catch (error) {
    next(error);
  }
};

const getRevenueAndProfit: RequestHandler<
  unknown,
  unknown,
  unknown,
  unknown
> = async (req, res, next) => {
  try {
  } catch (error) {}
};

export const orderController = {
  createOrder,
  updateOrder,
  getOrders,
  getOrder,
  getPurchaseHistory,
  getRevenueAndProfit,
};
