"use client";

import { useState, useEffect, Suspense } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import ProtectedRoute from "@/components/ProtectedRoute";
import TopicGrid from "@/components/TopicGrid";
import LawyerCard from "@/components/LawyerCard";
import LoadingSpinner from "@/components/LoadingSpinner";
import { consultationsApi, lawyersApi } from "@/lib/api";
import { LawyerProfileDto } from "@/lib/types";
import { LEGAL_TOPICS } from "@/lib/constants";

const STEPS = ["Topic", "Describe", "Lawyer", "Confirm"];

function NewConsultationContent() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const preselectedLawyer = searchParams.get("lawyerId");

  const [step, setStep] = useState(preselectedLawyer ? 0 : 0);
  const [topicId, setTopicId] = useState("");
  const [description, setDescription] = useState("");
  const [selectedLawyer, setSelectedLawyer] = useState<LawyerProfileDto | null>(null);
  const [lawyers, setLawyers] = useState<LawyerProfileDto[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    if (preselectedLawyer) {
      lawyersApi.getById(preselectedLawyer).then((l) => {
        setSelectedLawyer(l);
      }).catch(() => {});
    }
  }, [preselectedLawyer]);

  const fetchLawyers = async () => {
    setLoading(true);
    try {
      const res = await lawyersApi.search({ topicId: topicId || undefined, pageSize: 6 });
      setLawyers(res.items);
    } catch {
      setLawyers([]);
    } finally {
      setLoading(false);
    }
  };

  const handleNext = () => {
    if (step === 0 && !topicId) { setError("Select a legal topic"); return; }
    if (step === 1 && !description.trim()) { setError("Describe your problem"); return; }
    if (step === 2 && !selectedLawyer) { setError("Select a lawyer"); return; }
    setError("");
    if (step === 2) fetchLawyers();
    setStep(step + 1);
  };

  const handleSubmit = async () => {
    setLoading(true);
    setError("");
    try {
      const res = await consultationsApi.create({
        lawyerId: selectedLawyer?.userId,
        legalTopicId: topicId || undefined,
        type: 0,
        problemDescription: description,
      });
      router.push(`/consultations/${res.id}`);
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : "Failed to create consultation");
      setLoading(false);
    }
  };

  const selectedTopic = LEGAL_TOPICS.find((t) => t.id === topicId);

  return (
    <div className="max-w-3xl mx-auto px-4 py-8">
      <h1 className="text-2xl font-bold mb-6">New Consultation</h1>

      {/* Progress */}
      <div className="flex items-center mb-8">
        {STEPS.map((s, i) => (
          <div key={s} className="flex-1 flex items-center">
            <div className={`w-8 h-8 rounded-full flex items-center justify-center text-sm font-bold ${
              i <= step ? "bg-primary text-white" : "bg-gray-200 text-gray-500"
            }`}>
              {i + 1}
            </div>
            <span className={`hidden sm:block ml-2 text-sm ${i <= step ? "text-primary font-semibold" : "text-gray-400"}`}>
              {s}
            </span>
            {i < STEPS.length - 1 && <div className={`flex-1 h-0.5 mx-2 ${i < step ? "bg-primary" : "bg-gray-200"}`} />}
          </div>
        ))}
      </div>

      {/* Step 1: Topic */}
      {step === 0 && (
        <div>
          <h2 className="text-lg font-bold mb-4">What is your legal issue about?</h2>
          <TopicGrid onSelect={setTopicId} selected={topicId} />
        </div>
      )}

      {/* Step 2: Describe */}
      {step === 1 && (
        <div>
          <h2 className="text-lg font-bold mb-4">Describe your problem</h2>
          <p className="text-sm text-gray-500 mb-3">
            Write in simple words. No legal jargon needed. The more detail you provide, the better help you&apos;ll get.
          </p>
          <textarea
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            rows={6}
            placeholder="Tell us what happened..."
            className="w-full border border-gray-300 rounded-xl px-4 py-3 text-sm outline-none focus:ring-2 focus:ring-primary"
          />
        </div>
      )}

      {/* Step 3: Choose lawyer */}
      {step === 2 && (
        <div>
          <h2 className="text-lg font-bold mb-4">Choose a lawyer</h2>
          {selectedLawyer ? (
            <div className="mb-4">
              <LawyerCard lawyer={selectedLawyer} />
              <button onClick={() => setSelectedLawyer(null)} className="text-sm text-gray-500 mt-2 hover:text-primary">
                Choose a different lawyer
              </button>
            </div>
          ) : loading ? (
            <LoadingSpinner />
          ) : (
            <div className="grid gap-3">
              {lawyers.map((l) => (
                <div key={l.id} onClick={() => setSelectedLawyer(l)} className="cursor-pointer">
                  <LawyerCard lawyer={l} />
                </div>
              ))}
              {lawyers.length === 0 && (
                <p className="text-gray-500 text-sm">No available lawyers found. We&apos;ll auto-match you.</p>
              )}
            </div>
          )}
        </div>
      )}

      {/* Step 4: Confirm */}
      {step === 3 && (
        <div className="space-y-4">
          <h2 className="text-lg font-bold mb-4">Confirm Your Consultation</h2>
          <div className="bg-gray-50 rounded-xl p-4 space-y-3">
            <div className="flex justify-between text-sm">
              <span className="text-gray-500">Topic</span>
              <span className="font-semibold">{selectedTopic?.icon} {selectedTopic?.name}</span>
            </div>
            <div className="flex justify-between text-sm">
              <span className="text-gray-500">Lawyer</span>
              <span className="font-semibold">{selectedLawyer?.fullName || "Auto-match"}</span>
            </div>
            <div className="flex justify-between text-sm">
              <span className="text-gray-500">Fee</span>
              <span className="font-semibold text-primary">
                GHS {selectedLawyer?.consultationFee15Min?.toFixed(2) || "TBD"}
              </span>
            </div>
            <hr />
            <p className="text-sm text-gray-700">{description}</p>
          </div>

          <button
            className="w-full bg-accent text-primary py-4 rounded-full font-bold text-lg hover:bg-accent-light transition flex items-center justify-center gap-2"
            onClick={() => alert("MoMo payment stub — proceeding to create consultation")}
          >
            📱 Pay with Mobile Money
          </button>
        </div>
      )}

      {error && <p className="text-red-500 text-sm mt-4">{error}</p>}

      {/* Nav buttons */}
      <div className="flex justify-between mt-8">
        {step > 0 ? (
          <button onClick={() => setStep(step - 1)} className="text-gray-500 hover:text-primary font-semibold">
            ← Back
          </button>
        ) : <div />}
        {step < 3 ? (
          <button
            onClick={handleNext}
            className="bg-primary text-white px-8 py-3 rounded-full font-semibold hover:bg-primary-light transition"
          >
            Next →
          </button>
        ) : (
          <button
            onClick={handleSubmit}
            disabled={loading}
            className="bg-primary text-white px-8 py-3 rounded-full font-semibold hover:bg-primary-light transition disabled:opacity-50"
          >
            {loading ? "Creating..." : "Confirm & Start"}
          </button>
        )}
      </div>
    </div>
  );
}

export default function NewConsultationPage() {
  return (
    <ProtectedRoute>
      <Suspense fallback={<LoadingSpinner />}>
        <NewConsultationContent />
      </Suspense>
    </ProtectedRoute>
  );
}
