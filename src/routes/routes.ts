import { Router } from 'express';
import authRoute from './auth.route';
import orderRoute from './order.route';
import productRoute from './product.route';

const routes = Router();

routes.get('/', (req, res) => {
  res.send('Hello, TypeScript + Node.js + Express!');
});

routes.use(authRoute);
routes.use(productRoute);
routes.use(orderRoute);
export default routes;
