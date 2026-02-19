"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { rightsApi } from "@/lib/api";
import { KnowYourRightsArticle } from "@/lib/types";
import { LEGAL_TOPICS } from "@/lib/constants";
import LoadingSpinner from "@/components/LoadingSpinner";
import EmptyState from "@/components/EmptyState";

export default function RightsPage() {
  const [articles, setArticles] = useState<KnowYourRightsArticle[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState("");
  const [topicFilter, setTopicFilter] = useState("");

  useEffect(() => {
    rightsApi
      .list(topicFilter || undefined)
      .then(setArticles)
      .catch(() => setArticles([]))
      .finally(() => setLoading(false));
  }, [topicFilter]);

  const filtered = articles.filter(
    (a) =>
      a.title.toLowerCase().includes(search.toLowerCase()) ||
      a.content.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div className="max-w-7xl mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-2">Know Your Rights</h1>
      <p className="text-gray-600 mb-6">Learn about your legal rights in Ghana</p>

      {/* Search & Filter */}
      <div className="flex flex-col sm:flex-row gap-3 mb-6">
        <input
          type="text"
          placeholder="Search articles..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          className="flex-1 border border-gray-300 rounded-xl px-4 py-2 text-sm outline-none focus:ring-2 focus:ring-primary"
        />
        <select
          value={topicFilter}
          onChange={(e) => { setTopicFilter(e.target.value); setLoading(true); }}
          className="border border-gray-300 rounded-xl px-4 py-2 text-sm outline-none focus:ring-2 focus:ring-primary"
        >
          <option value="">All Topics</option>
          {LEGAL_TOPICS.map((t) => (
            <option key={t.id} value={t.id}>{t.icon} {t.name}</option>
          ))}
        </select>
      </div>

      {loading ? (
        <LoadingSpinner />
      ) : filtered.length === 0 ? (
        <EmptyState icon="📚" title="No articles found" message="Check back later for new content" />
      ) : (
        <div className="grid gap-4 md:grid-cols-2">
          {filtered.map((article) => (
            <Link
              key={article.id}
              href={`/rights/${article.slug}`}
              className="bg-white border border-gray-200 rounded-xl p-5 hover:shadow-lg transition"
            >
              <div className="flex items-center gap-2 mb-2">
                {article.legalTopicName && (
                  <span className="bg-primary/10 text-primary text-xs px-2 py-0.5 rounded-full">
                    {article.legalTopicName}
                  </span>
                )}
                <span className="text-xs text-gray-400">{article.viewCount} views</span>
              </div>
              <h3 className="font-bold text-gray-900 mb-1">{article.title}</h3>
              <p className="text-sm text-gray-600 line-clamp-3">{article.content.slice(0, 200)}...</p>
            </Link>
          ))}
        </div>
      )}
    </div>
  );
}
