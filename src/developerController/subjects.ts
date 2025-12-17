
import { Hono } from 'hono';
import { drizzle } from 'drizzle-orm/d1';
import * as schema from '../db/schema';
import { Env, Variables } from '../index';
import { adminOnly, authenticate } from '../middlewares/middleware';
import { eq, inArray } from 'drizzle-orm';
const subjectRoutesDeveloper = new Hono<{ Bindings: Env; Variables: Variables }>();
// get all subjects to Developer
subjectRoutesDeveloper.get('/', authenticate, adminOnly, async (c) => {
    const db = drizzle(c.env.myAppD1, { schema });
    const subjects = await db.query.subject.findMany(
        {
            with: {
                classesInvolved:
                {
                    columns: {
                        classRoomId: true

                    },
                    with: {
                        teacher: true
                    }


                }

            }
        }
    );
    return c.json(subjects, 200);
});
export default subjectRoutesDeveloper;
