import { Router } from 'express';
import { orderController } from '~/controllers';
import { authenticateToken, authorization, validate } from '~/middlewares';
import { createOrderSchema } from '~/schemas';

const orderRoute = Router();

orderRoute.get(
  '/orders',
  [authenticateToken, authorization(['admin'])],
  orderController.getOrders,
);

orderRoute.get('/orders/:id', orderController.getOrder);

orderRoute.put(
  '/orders/:id',
  [authenticateToken, authorization(['delivery-staff'])],
  orderController.updateOrder,
);

orderRoute.post(
  '/orders',
  [authenticateToken, authorization(['customer'])],
  validate(createOrderSchema),
  orderController.createOrder,
);

orderRoute.get(
  '/orders/purchase-history',
  [authenticateToken, authorization(['customer'])],
  orderController.getPurchaseHistory,
);

orderRoute.get('/revenue-profit', orderController.getRevenueAndProfit);

export default orderRoute;
