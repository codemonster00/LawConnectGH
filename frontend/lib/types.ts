// Auth
export interface RequestOtpDto {
  phoneOrEmail: string;
}

export interface VerifyOtpDto {
  phoneOrEmail: string;
  code: string;
}

export interface RegisterClientRequest {
  phoneNumber: string;
  fullName: string;
  email?: string;
  region?: string;
  city?: string;
  preferredLanguage?: string;
}

export interface RegisterLawyerRequest {
  phoneNumber: string;
  fullName: string;
  email?: string;
  barNumber: string;
  yearCalledToBar: number;
  bio?: string;
  lawFirm?: string;
  consultationFee15Min: number;
  consultationFee30Min: number;
  specializationTopicIds: string[];
}

export interface AuthResponse {
  token: string;
  refreshToken: string;
  expiresAt: string;
  userId: string;
  role: string;
}

// Lawyers
export interface LawyerProfileDto {
  id: string;
  userId: string;
  fullName: string;
  avatarUrl?: string;
  barNumber: string;
  yearCalledToBar: number;
  bio?: string;
  lawFirm?: string;
  consultationFee15Min: number;
  consultationFee30Min: number;
  isAvailable: boolean;
  verificationStatus: string;
  ratingAvg: number;
  ratingCount: number;
  totalConsultations: number;
  responseTimeAvgMin: number;
  specializations: string[];
}

export interface LawyerSearchRequest {
  query?: string;
  topicId?: string;
  region?: string;
  maxFee?: number;
  minRating?: number;
  isAvailable?: boolean;
  page?: number;
  pageSize?: number;
}

export interface LawyerSearchResponse {
  items: LawyerProfileDto[];
  totalCount: number;
  page: number;
  pageSize: number;
}

// Consultations
export interface ConsultationDto {
  id: string;
  clientId: string;
  clientName: string;
  lawyerId?: string;
  lawyerName?: string;
  legalTopicName?: string;
  status: string;
  type: string;
  durationMinutes?: number;
  problemDescription: string;
  startedAt?: string;
  endedAt?: string;
  clientRating?: number;
  totalFee: number;
  createdAt: string;
}

export interface ConsultationListDto {
  items: ConsultationDto[];
  totalCount: number;
}

export interface CreateConsultationRequest {
  lawyerId?: string;
  legalTopicId?: string;
  type: number; // 0=Chat, 1=DocumentReview
  problemDescription: string;
}

// Messages
export interface MessageDto {
  id: string;
  consultationId: string;
  senderId: string;
  content: string;
  messageType: number;
  attachmentUrl?: string;
  isRead: boolean;
  createdAt: string;
}

// Documents
export interface DocumentTemplateDto {
  id: string;
  name: string;
  description?: string;
  legalTopicName?: string;
  fieldsSchema?: string;
  price: number;
}

export interface GenerateDocumentRequest {
  templateId: string;
  consultationId?: string;
  title: string;
  fieldValues: Record<string, string>;
}

export interface GeneratedDocumentDto {
  id: string;
  title: string;
  templateName: string;
  status: string;
  fileUrl?: string;
  createdAt: string;
}

// Know Your Rights
export interface KnowYourRightsArticle {
  id: string;
  legalTopicId?: string;
  legalTopicName?: string;
  title: string;
  slug: string;
  content: string;
  language: string;
  isPublished: boolean;
  viewCount: number;
  createdAt: string;
}

// Legal Topics
export interface LegalTopic {
  id: string;
  name: string;
  slug: string;
  description?: string;
  icon?: string;
  displayOrder: number;
}

// User
export interface User {
  userId: string;
  role: string;
  fullName?: string;
}
