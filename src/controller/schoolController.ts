
import { Hono } from 'hono';
import { drizzle } from 'drizzle-orm/d1';
import { eq } from 'drizzle-orm';
import * as schema from '../db/schema';
import { Env, Variables } from '../index';
import bcrypt from 'bcryptjs';
import { adminOnly, checkAuthStatus, authenticate } from '../middlewares/middleware';
import { generateToken } from '../utils/jwt';
const schoolRoutes = new Hono<{ Bindings: Env; Variables: Variables }>();
// create school
schoolRoutes.post('/', authenticate, adminOnly, async (c) => {
    const body = await c.req.json();
    const adminId = c.get('user')
    const db = drizzle(c.env.myAppD1, { schema })
    const { name } = body;
    const school = await db.insert(schema.school).values({ name }).returning();
    return c.json({ school, adminId }, 201);
});

// get all schools
schoolRoutes.get('/', async (c) => {
    const db = drizzle(c.env.myAppD1, { schema })
    const schools = await db.select().from(schema.school)
    return c.json(schools, 200)
})

export default schoolRoutes;