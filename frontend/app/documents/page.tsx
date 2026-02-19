"use client";

import { useEffect, useState } from "react";
import PriceTag from "@/components/PriceTag";
import LoadingSpinner from "@/components/LoadingSpinner";
import EmptyState from "@/components/EmptyState";
import { documentsApi } from "@/lib/api";
import { DocumentTemplateDto, GeneratedDocumentDto } from "@/lib/types";
import { useAuth } from "@/components/AuthProvider";

export default function DocumentsPage() {
  const { user } = useAuth();
  const [tab, setTab] = useState<"templates" | "my">("templates");
  const [templates, setTemplates] = useState<DocumentTemplateDto[]>([]);
  const [myDocs, setMyDocs] = useState<GeneratedDocumentDto[]>([]);
  const [loading, setLoading] = useState(true);

  // Generate form
  const [selected, setSelected] = useState<DocumentTemplateDto | null>(null);
  const [title, setTitle] = useState("");
  const [fieldValues, setFieldValues] = useState<Record<string, string>>({});
  const [generating, setGenerating] = useState(false);
  const [preview, setPreview] = useState("");

  useEffect(() => {
    Promise.all([
      documentsApi.getTemplates().catch(() => []),
      user ? documentsApi.getMyDocuments().catch(() => []) : Promise.resolve([]),
    ]).then(([t, d]) => {
      setTemplates(t);
      setMyDocs(d);
      setLoading(false);
    });
  }, [user]);

  const getFields = (schema?: string): { name: string; label: string; type: string }[] => {
    if (!schema) return [];
    try {
      return JSON.parse(schema);
    } catch {
      return [];
    }
  };

  const handleGenerate = async () => {
    if (!selected || !title) return;
    setGenerating(true);
    try {
      const doc = await documentsApi.generate({ templateId: selected.id, title, fieldValues });
      setMyDocs((prev) => [doc, ...prev]);
      setPreview(`Document "${title}" generated successfully! (Content would appear here in production)`);
      setTab("my");
    } catch {
      setPreview("Failed to generate document. Please try again.");
    } finally {
      setGenerating(false);
    }
  };

  if (loading) return <LoadingSpinner />;

  return (
    <div className="max-w-7xl mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-6">Legal Documents</h1>

      {/* Tabs */}
      <div className="flex bg-gray-100 rounded-full p-1 mb-6 max-w-xs">
        {(["templates", "my"] as const).map((t) => (
          <button
            key={t}
            onClick={() => { setTab(t); setSelected(null); setPreview(""); }}
            className={`flex-1 py-2 rounded-full text-sm font-semibold transition ${
              tab === t ? "bg-primary text-white" : "text-gray-600"
            }`}
          >
            {t === "templates" ? "Templates" : "My Documents"}
          </button>
        ))}
      </div>

      {tab === "templates" && !selected && (
        <div className="grid gap-4 sm:grid-cols-2 md:grid-cols-3">
          {templates.length === 0 ? (
            <EmptyState icon="📄" title="No templates available" />
          ) : (
            templates.map((t) => (
              <button
                key={t.id}
                onClick={() => { setSelected(t); setTitle(""); setFieldValues({}); setPreview(""); }}
                className="bg-white border border-gray-200 rounded-xl p-5 text-left hover:shadow-lg transition"
              >
                <h3 className="font-bold text-gray-900 mb-1">{t.name}</h3>
                {t.description && <p className="text-sm text-gray-500 mb-2 line-clamp-2">{t.description}</p>}
                <div className="flex items-center justify-between">
                  {t.legalTopicName && (
                    <span className="bg-primary/10 text-primary text-xs px-2 py-0.5 rounded-full">{t.legalTopicName}</span>
                  )}
                  <PriceTag amount={t.price} className="text-sm" />
                </div>
              </button>
            ))
          )}
        </div>
      )}

      {tab === "templates" && selected && (
        <div className="max-w-lg">
          <button onClick={() => setSelected(null)} className="text-sm text-gray-500 hover:text-primary mb-4">
            ← Back to templates
          </button>
          <div className="bg-white border border-gray-200 rounded-xl p-6">
            <h2 className="text-xl font-bold mb-1">{selected.name}</h2>
            {selected.description && <p className="text-sm text-gray-500 mb-4">{selected.description}</p>}

            <div className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Document Title *</label>
                <input
                  type="text"
                  value={title}
                  onChange={(e) => setTitle(e.target.value)}
                  className="w-full border border-gray-300 rounded-xl px-4 py-2 text-sm outline-none focus:ring-2 focus:ring-primary"
                  placeholder="e.g. My Tenancy Agreement"
                />
              </div>

              {getFields(selected.fieldsSchema).map((field) => (
                <div key={field.name}>
                  <label className="block text-sm font-medium text-gray-700 mb-1">{field.label}</label>
                  <input
                    type={field.type || "text"}
                    value={fieldValues[field.name] || ""}
                    onChange={(e) => setFieldValues((prev) => ({ ...prev, [field.name]: e.target.value }))}
                    className="w-full border border-gray-300 rounded-xl px-4 py-2 text-sm outline-none focus:ring-2 focus:ring-primary"
                  />
                </div>
              ))}

              <div className="flex items-center justify-between pt-2">
                <PriceTag amount={selected.price} className="text-lg" />
                <button
                  onClick={handleGenerate}
                  disabled={generating || !title}
                  className="bg-primary text-white px-6 py-2 rounded-full font-semibold hover:bg-primary-light transition disabled:opacity-50"
                >
                  {generating ? "Generating..." : "Generate Document"}
                </button>
              </div>
            </div>

            {preview && (
              <div className="mt-4 bg-gray-50 rounded-xl p-4 text-sm text-gray-700">
                <h3 className="font-bold mb-2">Preview</h3>
                <p>{preview}</p>
                <button className="mt-3 text-primary font-semibold text-sm hover:underline">
                  📥 Download as PDF (stub)
                </button>
              </div>
            )}
          </div>
        </div>
      )}

      {tab === "my" && (
        <div>
          {myDocs.length === 0 ? (
            <EmptyState icon="📄" title="No documents yet" message="Generate your first legal document from a template" />
          ) : (
            <div className="grid gap-3">
              {myDocs.map((d) => (
                <div key={d.id} className="bg-white border border-gray-200 rounded-xl p-4 flex items-center justify-between">
                  <div>
                    <h3 className="font-semibold">{d.title}</h3>
                    <p className="text-sm text-gray-500">{d.templateName} · {new Date(d.createdAt).toLocaleDateString()}</p>
                  </div>
                  <div className="flex items-center gap-3">
                    <span className="text-xs bg-gray-100 px-2 py-1 rounded-full">{d.status}</span>
                    {d.fileUrl && (
                      <a href={d.fileUrl} className="text-primary text-sm font-semibold hover:underline">📥 Download</a>
                    )}
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      )}
    </div>
  );
}
