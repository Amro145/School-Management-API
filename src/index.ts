import { drizzle } from 'drizzle-orm/d1';
import { eq } from 'drizzle-orm';
import { Hono } from 'hono'
import * as schema from './db/schema';
import bcrypt from 'bcryptjs';
import userRoutes from './controller/userController';

export type Env = {
  MY_VAR: string;
  PRIVATE: string;
  myAppD1: D1Database;
  JWT_SECRET: string;
}
const app = new Hono<{ Bindings: Env }>()

app.route('/users', userRoutes);




export default app