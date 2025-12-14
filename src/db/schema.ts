import { relations, sql } from "drizzle-orm";
import { integer, sqliteTable, text } from "drizzle-orm/sqlite-core";



export const posts = sqliteTable("posts", {
    id: integer("id", { mode: "number" }).primaryKey({ autoIncrement: true }),
    userId: integer("userId", { mode: "number" }).notNull().references(() => users.id, { onDelete: "cascade" }),
    title: text("title", { length: 256 }).notNull(),
    content: text("content", { length: 256 }).notNull(),
    timestamp: text("timestamp").notNull().default(sql`CURRENT_TIMESTAMP`),
})

export const postRelation = relations(posts, ({ one, many }) => ({
    user: one(users, {
        fields: [posts.userId],
        references: [users.id],
    }),
    comments: many(comments),
}))

export const comments = sqliteTable("comments", {
    id: integer("id", { mode: "number" }).primaryKey({ autoIncrement: true }),
    postId: integer("post", { mode: "number" }).notNull()
        .references(() => posts.id, { onDelete: "cascade" }),
    content: text("content", { length: 256 }).notNull(),
    timestamp: text("timestamp").notNull().default(sql`CURRENT_TIMESTAMP`),

})

export const commentRelation = relations(comments, ({ one }) => ({
    post: one(posts, {
        fields: [comments.postId],
        references: [posts.id],
    })
}))