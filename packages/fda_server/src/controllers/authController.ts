import express, { Request, Response } from 'express';
import User from '../models/user';

class AuthController {
  public static async login(req: Request, res: Response) {
    try {
      const { email, password } = req.body;

      const user = await User.findOne({ email });

      if (!user) throw new Error('User not found');

      const isMatch = password == user.password;
      if (!isMatch) throw new Error('Invalid credentials');

      res.status(200).send({
        user: user,
      });
    } catch (error) {
      res.status(400).send(error);
    }
  }
}
export default AuthController;
