import bodyParser from 'body-parser';
import * as dotenv from 'dotenv';
import express, {
  type NextFunction,
  type Request,
  type Response,
} from 'express';
import { isHttpError } from 'http-errors';
import middleware from 'i18next-http-middleware';
import i18n from '~/i18n';
import routes from '~/routes';

dotenv.config();

const port = 6000;

const app = express();

app.use(middleware.handle(i18n, {}));
app.use(express.json());

app.use(
  bodyParser.json({
    limit: '50mb',
  }),
);
app.use(
  bodyParser.urlencoded({
    limit: '50mb',
    extended: true,
  }),
);

app.use('/api/', routes);

app.use((error: unknown, req: Request, res: Response, next: NextFunction) => {
  console.log(error);
  let errorMessage = 'An unknown error occurred';
  let statusCode = 500;
  if (isHttpError(error)) {
    statusCode = error.status;
    errorMessage = error.message;
  }
  res.status(statusCode).json({ error: errorMessage });
});

// start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
