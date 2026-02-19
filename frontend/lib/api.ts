import {
  AuthResponse,
  RegisterClientRequest,
  RegisterLawyerRequest,
  RequestOtpDto,
  VerifyOtpDto,
  LawyerSearchRequest,
  LawyerSearchResponse,
  LawyerProfileDto,
  ConsultationDto,
  ConsultationListDto,
  CreateConsultationRequest,
  MessageDto,
  DocumentTemplateDto,
  GenerateDocumentRequest,
  GeneratedDocumentDto,
  KnowYourRightsArticle,
} from "./types";

const BASE_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:5000/api/v1";

function getToken(): string | null {
  if (typeof window === "undefined") return null;
  return localStorage.getItem("token");
}

async function request<T>(path: string, options: RequestInit = {}): Promise<T> {
  const token = getToken();
  const headers: Record<string, string> = {
    "Content-Type": "application/json",
    ...((options.headers as Record<string, string>) || {}),
  };
  if (token) headers["Authorization"] = `Bearer ${token}`;

  const res = await fetch(`${BASE_URL}${path}`, { ...options, headers });
  if (!res.ok) {
    const body = await res.json().catch(() => ({}));
    throw new Error(body.message || `Request failed: ${res.status}`);
  }
  if (res.status === 204) return {} as T;
  return res.json();
}

// Auth
export const authApi = {
  requestOtp: (dto: RequestOtpDto) =>
    request<{ message: string; expiresAt: string }>("/auth/request-otp", { method: "POST", body: JSON.stringify(dto) }),
  verifyOtp: (dto: VerifyOtpDto) =>
    request<AuthResponse>("/auth/verify-otp", { method: "POST", body: JSON.stringify(dto) }),
  registerClient: (dto: RegisterClientRequest) =>
    request<AuthResponse>("/auth/register/client", { method: "POST", body: JSON.stringify(dto) }),
  registerLawyer: (dto: RegisterLawyerRequest) =>
    request<AuthResponse>("/auth/register/lawyer", { method: "POST", body: JSON.stringify(dto) }),
};

// Lawyers
export const lawyersApi = {
  search: (params: LawyerSearchRequest = {}) => {
    const qs = new URLSearchParams();
    if (params.query) qs.set("query", params.query);
    if (params.topicId) qs.set("topicId", params.topicId);
    if (params.region) qs.set("region", params.region);
    if (params.maxFee) qs.set("maxFee", params.maxFee.toString());
    if (params.minRating) qs.set("minRating", params.minRating.toString());
    if (params.isAvailable !== undefined) qs.set("isAvailable", params.isAvailable.toString());
    qs.set("page", (params.page || 1).toString());
    qs.set("pageSize", (params.pageSize || 20).toString());
    return request<LawyerSearchResponse>(`/lawyers?${qs}`);
  },
  getById: (id: string) => request<LawyerProfileDto>(`/lawyers/${id}`),
};

// Consultations
export const consultationsApi = {
  create: (dto: CreateConsultationRequest) =>
    request<ConsultationDto>("/consultations", { method: "POST", body: JSON.stringify(dto) }),
  list: () => request<ConsultationListDto>("/consultations"),
  getById: (id: string) => request<ConsultationDto>(`/consultations/${id}`),
  complete: (id: string) => request<{ message: string }>(`/consultations/${id}/complete`, { method: "PUT" }),
  cancel: (id: string) => request<{ message: string }>(`/consultations/${id}/cancel`, { method: "PUT" }),
};

// Messages (these endpoints assumed from the Message entity)
export const messagesApi = {
  list: (consultationId: string) =>
    request<MessageDto[]>(`/consultations/${consultationId}/messages`),
  send: (consultationId: string, content: string, messageType: number = 0) =>
    request<MessageDto>(`/consultations/${consultationId}/messages`, {
      method: "POST",
      body: JSON.stringify({ content, messageType }),
    }),
};

// Documents
export const documentsApi = {
  getTemplates: () => request<DocumentTemplateDto[]>("/documents/templates"),
  generate: (dto: GenerateDocumentRequest) =>
    request<GeneratedDocumentDto>("/documents/generate", { method: "POST", body: JSON.stringify(dto) }),
  getMyDocuments: () => request<GeneratedDocumentDto[]>("/documents/my"),
};

// Admin
export const adminApi = {
  getPendingLawyers: () => request<LawyerProfileDto[]>("/admin/lawyers/pending"),
  verifyLawyer: (id: string, approve: boolean) =>
    request<{ message: string }>(`/admin/lawyers/${id}/verify?approve=${approve}`, { method: "PUT" }),
};

// Know Your Rights (assumed endpoints)
export const rightsApi = {
  list: (topicId?: string) => {
    const qs = topicId ? `?topicId=${topicId}` : "";
    return request<KnowYourRightsArticle[]>(`/rights${qs}`);
  },
  getBySlug: (slug: string) => request<KnowYourRightsArticle>(`/rights/${slug}`),
};
