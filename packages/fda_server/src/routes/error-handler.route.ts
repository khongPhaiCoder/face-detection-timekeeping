import { Request, Response, NextFunction } from 'express';
import { StatusCodes } from 'http-status-codes';
import { CustomAPIError } from '../errors';

export default (err: CustomAPIError, req: Request, res: Response, next: NextFunction) => {
  console.error(err);

  const status: number = err.statusCode || StatusCodes.INTERNAL_SERVER_ERROR;
  const message: string = err.message || 'Something went wrong, try again later';
  const data = err.data;

  res.status(status).json({
    error: message,
    data,
  });
};
