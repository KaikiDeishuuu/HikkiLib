import { defineCollection, z } from 'astro:content';

const booksCollection = defineCollection({
  type: 'data',
  schema: z.object({
    title: z.string(),
    author: z.string(),
    description: z.string(),
    coverImage: z.string().optional(),
    tags: z.array(z.string()).default([]),
  })
});

const chaptersCollection = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    bookId: z.string(),
    chapterNumber: z.number(),
    isAppendix: z.boolean().default(false),
    publishedAt: z.date(),
  })
});

export const collections = {
  books: booksCollection,
  chapters: chaptersCollection,
};
