"use client";

import { useEffect, useState } from "react";
import { useParams } from "next/navigation";
import Link from "next/link";
import { rightsApi } from "@/lib/api";
import { KnowYourRightsArticle } from "@/lib/types";
import LoadingSpinner from "@/components/LoadingSpinner";

export default function ArticlePage() {
  const params = useParams();
  const [article, setArticle] = useState<KnowYourRightsArticle | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    rightsApi
      .getBySlug(params.slug as string)
      .then(setArticle)
      .catch(() => {})
      .finally(() => setLoading(false));
  }, [params.slug]);

  if (loading) return <LoadingSpinner />;
  if (!article) return <div className="text-center py-20 text-gray-500">Article not found</div>;

  return (
    <div className="max-w-3xl mx-auto px-4 py-8">
      <Link href="/rights" className="text-sm text-gray-500 hover:text-primary mb-4 inline-block">
        ← Back to articles
      </Link>
      <article>
        <div className="flex items-center gap-2 mb-4">
          {article.legalTopicName && (
            <span className="bg-primary/10 text-primary text-xs px-3 py-1 rounded-full font-semibold">
              {article.legalTopicName}
            </span>
          )}
          <span className="text-xs text-gray-400">{article.viewCount} views</span>
          <span className="text-xs text-gray-400">
            {new Date(article.createdAt).toLocaleDateString()}
          </span>
        </div>
        <h1 className="text-3xl font-bold text-gray-900 mb-6">{article.title}</h1>
        <div className="prose prose-slate max-w-none text-gray-700 leading-relaxed whitespace-pre-wrap">
          {article.content}
        </div>
      </article>
    </div>
  );
}
