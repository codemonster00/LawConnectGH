import Link from "next/link";
import { LEGAL_TOPICS } from "@/lib/constants";

export default function Home() {
  return (
    <div>
      {/* Hero */}
      <section className="bg-gradient-to-br from-primary to-primary-dark text-white py-16 md:py-24">
        <div className="max-w-7xl mx-auto px-4 text-center">
          <h1 className="text-4xl md:text-6xl font-bold mb-4">
            Your Lawyer, <span className="text-accent">One Tap Away</span>
          </h1>
          <p className="text-lg md:text-xl text-gray-300 mb-8 max-w-2xl mx-auto">
            Connect with verified Ghanaian lawyers for affordable legal consultations. Get expert advice from the comfort of your phone.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Link href="/consultations/new" className="bg-accent text-primary px-8 py-4 rounded-full font-bold text-lg hover:bg-accent-light transition">
              Get Legal Help Now
            </Link>
            <Link href="/lawyers" className="border-2 border-white text-white px-8 py-4 rounded-full font-bold text-lg hover:bg-white/10 transition">
              Browse Lawyers
            </Link>
          </div>
        </div>
      </section>

      {/* How it works */}
      <section className="py-16 bg-gray-50">
        <div className="max-w-7xl mx-auto px-4">
          <h2 className="text-3xl font-bold text-center mb-12">How It Works</h2>
          <div className="grid md:grid-cols-3 gap-8">
            {[
              { step: "1", icon: "📝", title: "Describe Your Issue", desc: "Tell us about your legal problem in simple words. No legal jargon needed." },
              { step: "2", icon: "🤝", title: "Get Matched", desc: "We match you with a verified lawyer who specializes in your type of case." },
              { step: "3", icon: "💬", title: "Consult", desc: "Chat with your lawyer securely. Get advice, documents, and peace of mind." },
            ].map((item) => (
              <div key={item.step} className="bg-white rounded-xl p-8 text-center shadow-sm">
                <div className="text-5xl mb-4">{item.icon}</div>
                <div className="text-accent font-bold text-sm mb-2">STEP {item.step}</div>
                <h3 className="text-xl font-bold mb-2">{item.title}</h3>
                <p className="text-gray-600">{item.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Legal Topics */}
      <section className="py-16">
        <div className="max-w-7xl mx-auto px-4">
          <h2 className="text-3xl font-bold text-center mb-4">Legal Topics We Cover</h2>
          <p className="text-gray-600 text-center mb-12">From land disputes to family matters — we have lawyers for every need.</p>
          <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-4">
            {LEGAL_TOPICS.map((topic) => (
              <Link
                key={topic.id}
                href={`/lawyers?topic=${topic.slug}`}
                className="bg-white border border-gray-200 rounded-xl p-5 text-center hover:shadow-lg hover:border-primary/30 transition"
              >
                <div className="text-3xl mb-2">{topic.icon}</div>
                <div className="font-semibold text-sm text-gray-800">{topic.name}</div>
              </Link>
            ))}
          </div>
        </div>
      </section>

      {/* Pricing */}
      <section className="py-16 bg-gray-50">
        <div className="max-w-7xl mx-auto px-4">
          <h2 className="text-3xl font-bold text-center mb-12">Affordable Legal Help</h2>
          <div className="grid md:grid-cols-2 gap-8 max-w-3xl mx-auto">
            <div className="bg-white rounded-xl p-8 shadow-sm border-2 border-primary">
              <h3 className="text-xl font-bold mb-2">💬 Consultations</h3>
              <div className="text-3xl font-bold text-primary mb-2">GHS 30 – 150</div>
              <p className="text-gray-600 mb-4">Chat with a verified lawyer about your legal issue.</p>
              <ul className="space-y-2 text-sm text-gray-600">
                <li>✓ 15-minute or 30-minute sessions</li>
                <li>✓ Secure & confidential chat</li>
                <li>✓ Expert legal advice</li>
                <li>✓ Follow-up support</li>
              </ul>
            </div>
            <div className="bg-white rounded-xl p-8 shadow-sm border-2 border-accent">
              <h3 className="text-xl font-bold mb-2">📄 Documents</h3>
              <div className="text-3xl font-bold text-accent-dark mb-2">GHS 20 – 100</div>
              <p className="text-gray-600 mb-4">Generate legal documents tailored to your needs.</p>
              <ul className="space-y-2 text-sm text-gray-600">
                <li>✓ Rental agreements</li>
                <li>✓ Business contracts</li>
                <li>✓ Wills & power of attorney</li>
                <li>✓ Lawyer-reviewed templates</li>
              </ul>
            </div>
          </div>
        </div>
      </section>

      {/* Trust Signals */}
      <section className="py-16">
        <div className="max-w-7xl mx-auto px-4">
          <div className="grid md:grid-cols-3 gap-8 text-center">
            {[
              { icon: "✅", title: "Verified Lawyers Only", desc: "Every lawyer is bar-certified and vetted by our team." },
              { icon: "🔒", title: "Secure & Confidential", desc: "Your conversations and data are encrypted and private." },
              { icon: "📱", title: "MoMo Payments", desc: "Pay conveniently with Mobile Money — MTN, Vodafone, AirtelTigo." },
            ].map((item) => (
              <div key={item.title} className="p-6">
                <div className="text-4xl mb-3">{item.icon}</div>
                <h3 className="text-lg font-bold mb-2">{item.title}</h3>
                <p className="text-gray-600">{item.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="py-16 bg-primary text-white text-center">
        <div className="max-w-7xl mx-auto px-4">
          <h2 className="text-3xl font-bold mb-4">Ready to Get Legal Help?</h2>
          <p className="text-gray-300 mb-8 max-w-lg mx-auto">
            Join thousands of Ghanaians who trust LawConnect GH for their legal needs.
          </p>
          <Link href="/auth/register" className="bg-accent text-primary px-8 py-4 rounded-full font-bold text-lg hover:bg-accent-light transition inline-block">
            Create Free Account
          </Link>
        </div>
      </section>
    </div>
  );
}
