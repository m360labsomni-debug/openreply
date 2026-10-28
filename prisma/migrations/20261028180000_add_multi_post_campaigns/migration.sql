-- AlterTable: a campaign can now listen on several posts/reels.
ALTER TABLE "Automation" ADD COLUMN "postIds" TEXT[] DEFAULT ARRAY[]::TEXT[];

-- Backfill: existing single-post campaigns keep their post.
UPDATE "Automation" SET "postIds" = ARRAY["postId"] WHERE "postId" IS NOT NULL;

-- Look up campaigns by any of their posts.
CREATE INDEX "Automation_postIds_idx" ON "Automation" USING GIN ("postIds");
