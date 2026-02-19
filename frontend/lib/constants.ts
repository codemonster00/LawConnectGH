export const LEGAL_TOPICS = [
  { id: "1", name: "Land & Property", slug: "land-property", icon: "🏠", description: "Land disputes, property rights, tenancy" },
  { id: "2", name: "Family Law", slug: "family-law", icon: "👨‍👩‍👧‍👦", description: "Marriage, divorce, child custody, inheritance" },
  { id: "3", name: "Criminal Law", slug: "criminal-law", icon: "⚖️", description: "Criminal defense, bail, representation" },
  { id: "4", name: "Business & Corporate", slug: "business-corporate", icon: "💼", description: "Company registration, contracts, partnerships" },
  { id: "5", name: "Employment Law", slug: "employment-law", icon: "👷", description: "Wrongful termination, wages, workplace rights" },
  { id: "6", name: "Consumer Rights", slug: "consumer-rights", icon: "🛒", description: "Product disputes, refunds, warranties" },
  { id: "7", name: "Debt & Finance", slug: "debt-finance", icon: "💰", description: "Debt recovery, loans, financial disputes" },
  { id: "8", name: "Immigration", slug: "immigration", icon: "✈️", description: "Visas, permits, citizenship, deportation" },
  { id: "9", name: "Human Rights", slug: "human-rights", icon: "✊", description: "Civil liberties, discrimination, freedom of speech" },
  { id: "10", name: "Insurance", slug: "insurance", icon: "🛡️", description: "Claims, disputes, coverage issues" },
  { id: "11", name: "Tax Law", slug: "tax-law", icon: "📊", description: "Tax disputes, compliance, planning" },
  { id: "12", name: "Chieftaincy & Customary", slug: "chieftaincy-customary", icon: "👑", description: "Traditional law, chieftaincy disputes" },
];

export const GHANA_REGIONS = [
  "Greater Accra", "Ashanti", "Western", "Eastern", "Central",
  "Northern", "Volta", "Upper East", "Upper West", "Brong-Ahafo",
  "Western North", "Ahafo", "Bono East", "Oti", "North East", "Savannah",
];

export const CONSULTATION_STATUSES: Record<string, { label: string; color: string }> = {
  Requested: { label: "Requested", color: "bg-yellow-100 text-yellow-800" },
  Matched: { label: "Matched", color: "bg-blue-100 text-blue-800" },
  Active: { label: "Active", color: "bg-green-100 text-green-800" },
  Completed: { label: "Completed", color: "bg-gray-100 text-gray-800" },
  Cancelled: { label: "Cancelled", color: "bg-red-100 text-red-800" },
  Disputed: { label: "Disputed", color: "bg-orange-100 text-orange-800" },
};
