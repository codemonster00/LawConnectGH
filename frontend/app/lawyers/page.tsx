"use client";

import { useEffect, useState, Suspense } from "react";
import { useSearchParams } from "next/navigation";
import LawyerCard from "@/components/LawyerCard";
import LoadingSpinner from "@/components/LoadingSpinner";
import EmptyState from "@/components/EmptyState";
import { lawyersApi } from "@/lib/api";
import { LawyerProfileDto } from "@/lib/types";
import { LEGAL_TOPICS, GHANA_REGIONS } from "@/lib/constants";

function LawyersContent() {
  const searchParams = useSearchParams();
  const [lawyers, setLawyers] = useState<LawyerProfileDto[]>([]);
  const [loading, setLoading] = useState(true);
  const [totalCount, setTotalCount] = useState(0);
  const [page, setPage] = useState(1);

  const [query, setQuery] = useState("");
  const [topic, setTopic] = useState(searchParams.get("topic") || "");
  const [region, setRegion] = useState("");
  const [maxFee, setMaxFee] = useState("");

  const fetchLawyers = async (p: number = 1) => {
    setLoading(true);
    try {
      const topicObj = LEGAL_TOPICS.find((t) => t.slug === topic || t.id === topic);
      const res = await lawyersApi.search({
        query: query || undefined,
        topicId: topicObj?.id,
        region: region || undefined,
        maxFee: maxFee ? parseFloat(maxFee) : undefined,
        page: p,
        pageSize: 12,
      });
      setLawyers(res.items);
      setTotalCount(res.totalCount);
      setPage(p);
    } catch {
      setLawyers([]);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchLawyers();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    fetchLawyers(1);
  };

  const totalPages = Math.ceil(totalCount / 12);
  const inputClass = "bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white outline-none focus:border-[#d4a843] transition placeholder-gray-500";

  return (
    <div className="max-w-7xl mx-auto px-4 py-8 text-white">
      <h1 className="text-3xl font-bold mb-2">Find a <span className="gradient-text">Lawyer</span></h1>
      <p className="text-gray-400 mb-6">Browse verified lawyers across Ghana</p>

      {/* Filters */}
      <form onSubmit={handleSearch} className="glass-strong rounded-2xl p-5 mb-8">
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-5 gap-3">
          <input type="text" placeholder="Search by name..." value={query} onChange={(e) => setQuery(e.target.value)} className={inputClass} />
          <select value={topic} onChange={(e) => setTopic(e.target.value)} className={inputClass}>
            <option value="">All Topics</option>
            {LEGAL_TOPICS.map((t) => (<option key={t.id} value={t.id}>{t.icon} {t.name}</option>))}
          </select>
          <select value={region} onChange={(e) => setRegion(e.target.value)} className={inputClass}>
            <option value="">All Regions</option>
            {GHANA_REGIONS.map((r) => (<option key={r} value={r}>{r}</option>))}
          </select>
          <input type="number" placeholder="Max fee (GHS)" value={maxFee} onChange={(e) => setMaxFee(e.target.value)} className={inputClass} />
          <button type="submit" className="btn-shimmer bg-gradient-to-r from-[#d4a843] to-[#e0be6a] text-[#0a1628] rounded-full py-2 px-6 font-semibold transition text-sm">
            Search
          </button>
        </div>
      </form>

      {loading ? (
        <LoadingSpinner />
      ) : lawyers.length === 0 ? (
        <EmptyState icon="🔍" title="No lawyers found" message="Try adjusting your filters" />
      ) : (
        <>
          <p className="text-sm text-gray-500 mb-4">{totalCount} lawyer{totalCount !== 1 ? "s" : ""} found</p>
          <div className="grid gap-4 md:grid-cols-2">
            {lawyers.map((l) => (
              <div key={l.id} className="tilt-card">
                <LawyerCard lawyer={l} />
              </div>
            ))}
          </div>
          {totalPages > 1 && (
            <div className="flex justify-center gap-2 mt-8">
              {Array.from({ length: totalPages }, (_, i) => (
                <button
                  key={i}
                  onClick={() => fetchLawyers(i + 1)}
                  className={`w-10 h-10 rounded-full text-sm font-semibold transition ${
                    page === i + 1 ? "bg-gradient-to-r from-[#d4a843] to-[#e0be6a] text-[#0a1628]" : "glass text-gray-400 hover:text-white"
                  }`}
                >
                  {i + 1}
                </button>
              ))}
            </div>
          )}
        </>
      )}
    </div>
  );
}

export default function LawyersPage() {
  return (
    <Suspense fallback={<LoadingSpinner />}>
      <LawyersContent />
    </Suspense>
  );
}
