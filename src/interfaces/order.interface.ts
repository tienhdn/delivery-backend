import {
  CreationOptional,
  type InferAttributes,
  type InferCreationAttributes,
  type Model,
} from 'sequelize';
import { OrderStatus } from './order-status.interface';

export interface Order {
  id: number;
  customer_id: number;
  total_price: number;
  delivery_id: number;
  status: OrderStatus;
  created_at?: Date;
  updated_at?: Date;
}

export type OrderCreation = Partial<
  Pick<Order, 'delivery_id' | 'customer_id'>
> &
  Omit<Order, 'delivery_id' | 'customer_id' | 'id'>;

export interface OrderModelDefined
  extends Model<
      InferAttributes<OrderModelDefined>,
      InferCreationAttributes<OrderModelDefined>
    >,
    OrderCreation {
  id?: CreationOptional<number>;
}
