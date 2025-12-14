import { drizzle } from 'drizzle-orm/d1';
import { Hono } from 'hono'
import { posts } from './db/schema';

export type Env = {
  MY_VAR: string;
  PRIVATE: string;
  myAppD1: D1Database;
}
const app = new Hono<{ Bindings: Env }>()

app.get('/posts', async (c) => {
  const db = drizzle(c.env.myAppD1)
  const result = await db.select().from(posts)
  return c.json(result)

})
.post("/post", async (c) => {
  const db = drizzle(c.env.myAppD1)
  const { title, content } = await c.req.json()
  const result = await db.insert(posts).values({ title, content }).returning()
  return c.json(result)
})
export default app
