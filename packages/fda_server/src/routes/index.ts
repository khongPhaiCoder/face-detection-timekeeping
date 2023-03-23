import express, { Request, Response } from 'express';

import file from './file';
import auth from './auth';

const router = express.Router();

router.use('/file', file);
router.use('/authentication', auth);

export default router;
