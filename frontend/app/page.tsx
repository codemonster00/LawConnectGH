"use client";

import Link from "next/link";
import { LEGAL_TOPICS } from "@/lib/constants";
import { useInView } from "@/hooks/useInView";
import { useEffect, useState, useRef } from "react";

/* ─── Animated Counter ─── */
function Counter({ end, suffix = "", duration = 2000 }: { end: number; suffix?: string; duration?: number }) {
  const { ref, inView } = useInView(0.3);
  const [count, setCount] = useState(0);

  useEffect(() => {
    if (!inView) return;
    let start = 0;
    const step = end / (duration / 16);
    const timer = setInterval(() => {
      start += step;
      if (start >= end) { setCount(end); clearInterval(timer); }
      else setCount(Math.floor(start));
    }, 16);
    return () => clearInterval(timer);
  }, [inView, end, duration]);

  return <span ref={ref}>{count.toLocaleString()}{suffix}</span>;
}

/* ─── Section wrapper with scroll animation ─── */
function AnimatedSection({ children, className = "" }: { children: React.ReactNode; className?: string }) {
  const { ref, inView } = useInView(0.1);
  return (
    <div ref={ref} className={`${inView ? "inview-visible" : "inview-hidden"} ${className}`}>
      {children}
    </div>
  );
}

/* ─── Particles ─── */
function Particles() {
  return (
    <div className="absolute inset-0 overflow-hidden pointer-events-none">
      {Array.from({ length: 20 }).map((_, i) => (
        <div
          key={i}
          className="particle"
          style={{
            left: `${Math.random() * 100}%`,
            top: `${Math.random() * 100}%`,
            width: `${2 + Math.random() * 4}px`,
            height: `${2 + Math.random() * 4}px`,
            animationDuration: `${8 + Math.random() * 12}s`,
            animationDelay: `${Math.random() * 8}s`,
            background: Math.random() > 0.5 ? "rgba(212,168,67,0.3)" : "rgba(59,130,246,0.2)",
          }}
        />
      ))}
    </div>
  );
}

/* ─── 3D Scales of Justice ─── */
function ScalesOfJustice() {
  return (
    <div className="perspective mx-auto w-48 h-48 md:w-64 md:h-64">
      <div className="preserve-3d animate-scale-float w-full h-full relative">
        {/* Pillar */}
        <div className="absolute left-1/2 top-[20%] w-1 h-[60%] bg-gradient-to-b from-yellow-400 to-yellow-600 -translate-x-1/2 rounded-full" />
        {/* Base */}
        <div className="absolute bottom-[15%] left-1/2 -translate-x-1/2 w-20 md:w-28 h-2 bg-gradient-to-r from-yellow-500 to-yellow-600 rounded-full shadow-lg" />
        {/* Beam */}
        <div className="absolute top-[20%] left-1/2 -translate-x-1/2 w-36 md:w-48 h-1 bg-gradient-to-r from-yellow-400 via-yellow-500 to-yellow-400 rounded-full" />
        {/* Left pan */}
        <div className="absolute top-[22%] left-[8%] md:left-[6%]">
          <div className="w-0.5 h-10 bg-yellow-500 mx-auto" />
          <div className="w-12 md:w-16 h-6 bg-gradient-to-b from-yellow-500/80 to-yellow-600/60 rounded-b-full mx-auto animate-float" style={{ animationDelay: "0s" }} />
        </div>
        {/* Right pan */}
        <div className="absolute top-[22%] right-[8%] md:right-[6%]">
          <div className="w-0.5 h-8 bg-yellow-500 mx-auto" />
          <div className="w-12 md:w-16 h-6 bg-gradient-to-b from-yellow-500/80 to-yellow-600/60 rounded-b-full mx-auto animate-float" style={{ animationDelay: "1.5s" }} />
        </div>
        {/* Top ornament */}
        <div className="absolute top-[14%] left-1/2 -translate-x-1/2 w-4 h-4 bg-yellow-400 rounded-full shadow-[0_0_20px_rgba(212,168,67,0.6)]" />
      </div>
    </div>
  );
}

export default function Home() {
  const [mousePos, setMousePos] = useState({ x: 0, y: 0 });
  const heroRef = useRef<HTMLDivElement>(null);

  return (
    <div className="bg-[#0a1628] text-white">
      {/* ═══ HERO ═══ */}
      <section ref={heroRef} className="relative min-h-[90vh] flex items-center overflow-hidden dot-pattern">
        <Particles />
        {/* Gradient orbs */}
        <div className="absolute top-20 right-20 w-72 h-72 bg-blue-500/10 rounded-full blur-3xl" />
        <div className="absolute bottom-20 left-10 w-96 h-96 bg-yellow-500/5 rounded-full blur-3xl" />

        <div className="max-w-7xl mx-auto px-4 py-20 grid md:grid-cols-2 gap-12 items-center relative z-10">
          <div>
            <div className="inline-block glass rounded-full px-4 py-1.5 text-sm text-gray-300 mb-6">
              ⚖️ Ghana&apos;s #1 Legal Platform
            </div>
            <h1 className="text-4xl md:text-6xl lg:text-7xl font-bold leading-tight mb-6">
              Your Lawyer,{" "}
              <span className="gradient-text">One Tap Away</span>
            </h1>
            <p className="text-lg md:text-xl text-gray-400 mb-10 max-w-lg">
              Connect with verified Ghanaian lawyers for affordable legal consultations. Get expert advice from the comfort of your phone.
            </p>

            {/* Glass card CTA */}
            <div className="glass-strong rounded-2xl p-6 max-w-lg">
              <p className="text-sm text-gray-400 mb-3">Describe your legal issue</p>
              <div className="flex gap-3">
                <input
                  type="text"
                  placeholder="E.g. land dispute, divorce, business contract..."
                  className="flex-1 bg-white/5 border border-white/10 rounded-xl px-4 py-3 text-white placeholder-gray-500 focus:border-[#d4a843] focus:outline-none transition"
                />
                <Link
                  href="/consultations/new"
                  className="btn-shimmer bg-gradient-to-r from-[#d4a843] to-[#e0be6a] text-[#0a1628] px-6 py-3 rounded-xl font-bold hover:shadow-[0_0_30px_rgba(212,168,67,0.4)] transition-all whitespace-nowrap"
                >
                  Get Help
                </Link>
              </div>
            </div>
          </div>

          <div className="hidden md:flex justify-center">
            <ScalesOfJustice />
          </div>
        </div>
      </section>

      {/* ═══ STATS ═══ */}
      <section className="py-16 relative">
        <div className="max-w-5xl mx-auto px-4">
          <AnimatedSection>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
              {[
                { end: 500, suffix: "+", label: "Verified Lawyers" },
                { end: 10000, suffix: "+", label: "Cases Resolved" },
                { end: 4, suffix: ".8★", label: "Average Rating" },
                { end: 16, suffix: "", label: "Regions Covered" },
              ].map((stat) => (
                <div key={stat.label} className="glass rounded-2xl p-6 text-center hover:bg-white/[0.08] transition">
                  <div className="text-3xl md:text-4xl font-bold gradient-text mb-2">
                    <Counter end={stat.end} suffix={stat.suffix} />
                  </div>
                  <div className="text-sm text-gray-400">{stat.label}</div>
                </div>
              ))}
            </div>
          </AnimatedSection>
        </div>
      </section>

      {/* ═══ HOW IT WORKS ═══ */}
      <section className="py-20 grid-pattern">
        <div className="max-w-7xl mx-auto px-4">
          <AnimatedSection>
            <h2 className="text-3xl md:text-4xl font-bold text-center mb-4">
              How It <span className="gradient-text">Works</span>
            </h2>
            <p className="text-gray-400 text-center mb-16 max-w-xl mx-auto">
              Three simple steps to get the legal help you need.
            </p>
          </AnimatedSection>

          <div className="grid md:grid-cols-3 gap-8 relative">
            {/* Connecting line */}
            <div className="hidden md:block absolute top-1/2 left-[15%] right-[15%] h-px border-t-2 border-dashed border-white/10 -translate-y-1/2" />

            {[
              { step: "01", icon: "📝", title: "Describe Your Issue", desc: "Tell us about your legal problem in simple words. No legal jargon needed.", back: "We use AI to match your description with the right legal expertise." },
              { step: "02", icon: "🤝", title: "Get Matched", desc: "We match you with a verified lawyer who specializes in your type of case.", back: "Choose from top-rated lawyers with transparent fees and reviews." },
              { step: "03", icon: "💬", title: "Consult Securely", desc: "Chat with your lawyer securely. Get advice, documents, and peace of mind.", back: "Encrypted chat, file sharing, and follow-up support included." },
            ].map((item, i) => (
              <AnimatedSection key={item.step} className={`delay-${(i + 1) * 200}`}>
                <div className="flip-card h-72">
                  <div className="flip-card-inner">
                    {/* Front */}
                    <div className="flip-card-front glass rounded-2xl p-8 flex flex-col items-center justify-center text-center">
                      <div className="text-5xl mb-4 animate-float" style={{ animationDelay: `${i * 0.5}s` }}>{item.icon}</div>
                      <div className="text-[#d4a843] font-mono text-sm mb-2">STEP {item.step}</div>
                      <h3 className="text-xl font-bold mb-2">{item.title}</h3>
                      <p className="text-gray-400 text-sm">{item.desc}</p>
                    </div>
                    {/* Back */}
                    <div className="flip-card-back glass-strong rounded-2xl p-8 flex flex-col items-center justify-center text-center">
                      <div className="text-[#d4a843] font-mono text-sm mb-3">DETAILS</div>
                      <p className="text-gray-300">{item.back}</p>
                      <Link href="/consultations/new" className="mt-4 text-[#d4a843] hover:underline text-sm font-semibold">
                        Get Started →
                      </Link>
                    </div>
                  </div>
                </div>
              </AnimatedSection>
            ))}
          </div>
        </div>
      </section>

      {/* ═══ LEGAL TOPICS ═══ */}
      <section className="py-20">
        <div className="max-w-7xl mx-auto px-4">
          <AnimatedSection>
            <h2 className="text-3xl md:text-4xl font-bold text-center mb-4">
              Legal Topics We <span className="gradient-text">Cover</span>
            </h2>
            <p className="text-gray-400 text-center mb-12">From land disputes to family matters — we have lawyers for every need.</p>
          </AnimatedSection>

          <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-4">
            {LEGAL_TOPICS.map((topic, i) => (
              <AnimatedSection key={topic.id}>
                <Link
                  href={`/lawyers?topic=${topic.slug}`}
                  className="tilt-card glass rounded-2xl p-5 text-center block hover:border-[#d4a843]/30 hover:shadow-[0_0_30px_rgba(212,168,67,0.1)] transition-all group"
                >
                  <div className="text-3xl mb-3 animate-float" style={{ animationDelay: `${i * 0.2}s` }}>{topic.icon}</div>
                  <div className="font-semibold text-sm text-gray-200 group-hover:text-[#d4a843] transition">{topic.name}</div>
                </Link>
              </AnimatedSection>
            ))}
          </div>
        </div>
      </section>

      {/* ═══ TESTIMONIALS ═══ */}
      <section className="py-20 overflow-hidden grid-pattern">
        <div className="max-w-7xl mx-auto px-4">
          <AnimatedSection>
            <h2 className="text-3xl md:text-4xl font-bold text-center mb-12">
              Trusted by <span className="gradient-text">Thousands</span>
            </h2>
          </AnimatedSection>

          <div className="flex animate-marquee gap-6" style={{ width: "max-content" }}>
            {[...Array(2)].flatMap((_, setIdx) =>
              [
                { name: "Ama Serwaa", loc: "Accra", text: "LawConnect helped me resolve my land dispute in weeks. The lawyer was professional and affordable.", rating: 5 },
                { name: "Kofi Mensah", loc: "Kumasi", text: "I got my business registered with help from a verified corporate lawyer. Seamless experience!", rating: 5 },
                { name: "Abena Osei", loc: "Takoradi", text: "The divorce process was handled with sensitivity. My lawyer was empathetic and knowledgeable.", rating: 4 },
                { name: "Kwame Boateng", loc: "Tamale", text: "Affordable legal advice right from my phone. No more traveling hours to see a lawyer.", rating: 5 },
                { name: "Efua Ansah", loc: "Cape Coast", text: "Generated a rental agreement in minutes. The templates are professional and legally sound.", rating: 5 },
                { name: "Yaw Frimpong", loc: "Sunyani", text: "Got help with an employment dispute. My lawyer fought for my rights and we won!", rating: 5 },
              ].map((t, i) => (
                <div key={`${setIdx}-${i}`} className="glass rounded-2xl p-6 min-w-[300px] max-w-[340px] flex-shrink-0">
                  <div className="flex gap-1 mb-3">
                    {Array.from({ length: 5 }).map((_, s) => (
                      <span key={s} className={`text-sm ${s < t.rating ? "animate-gold-shimmer" : "text-gray-600"}`}>★</span>
                    ))}
                  </div>
                  <p className="text-gray-300 text-sm mb-4">&ldquo;{t.text}&rdquo;</p>
                  <div className="text-sm font-semibold text-white">{t.name}</div>
                  <div className="text-xs text-gray-500">{t.loc}</div>
                </div>
              ))
            )}
          </div>
        </div>
      </section>

      {/* ═══ PRICING ═══ */}
      <section className="py-20">
        <div className="max-w-4xl mx-auto px-4">
          <AnimatedSection>
            <h2 className="text-3xl md:text-4xl font-bold text-center mb-4">
              Affordable <span className="gradient-text">Legal Help</span>
            </h2>
            <p className="text-gray-400 text-center mb-12">Transparent pricing. No hidden fees.</p>
          </AnimatedSection>

          <div className="grid md:grid-cols-2 gap-8">
            {[
              {
                title: "💬 Consultations",
                price: "GHS 30 – 150",
                desc: "Chat with a verified lawyer about your legal issue.",
                features: ["15-minute or 30-minute sessions", "Secure & confidential chat", "Expert legal advice", "Follow-up support"],
                popular: false,
                border: "border-blue-500/30",
                glow: "hover:shadow-[0_0_40px_rgba(59,130,246,0.15)]",
              },
              {
                title: "📄 Documents",
                price: "GHS 20 – 100",
                desc: "Generate legal documents tailored to your needs.",
                features: ["Rental agreements", "Business contracts", "Wills & power of attorney", "Lawyer-reviewed templates"],
                popular: true,
                border: "border-[#d4a843]/50",
                glow: "hover:shadow-[0_0_40px_rgba(212,168,67,0.2)]",
              },
            ].map((plan) => (
              <AnimatedSection key={plan.title}>
                <div className={`glass rounded-2xl p-8 border ${plan.border} ${plan.glow} transition-all relative ${plan.popular ? "md:-translate-y-2 animate-pulse-glow" : ""}`}>
                  {plan.popular && (
                    <div className="absolute -top-3 left-1/2 -translate-x-1/2 bg-gradient-to-r from-[#d4a843] to-[#e0be6a] text-[#0a1628] text-xs font-bold px-4 py-1 rounded-full">
                      MOST POPULAR
                    </div>
                  )}
                  <h3 className="text-xl font-bold mb-2">{plan.title}</h3>
                  <div className="text-3xl font-bold gradient-text mb-2">{plan.price}</div>
                  <p className="text-gray-400 mb-6 text-sm">{plan.desc}</p>
                  <ul className="space-y-3 text-sm text-gray-300">
                    {plan.features.map((f) => (
                      <li key={f} className="flex items-center gap-2">
                        <span className="text-[#d4a843]">✓</span> {f}
                      </li>
                    ))}
                  </ul>
                </div>
              </AnimatedSection>
            ))}
          </div>
        </div>
      </section>

      {/* ═══ TRUST SIGNALS ═══ */}
      <section className="py-16 grid-pattern">
        <div className="max-w-5xl mx-auto px-4">
          <AnimatedSection>
            <div className="grid md:grid-cols-3 gap-6">
              {[
                { icon: "✅", title: "Verified Lawyers Only", desc: "Every lawyer is bar-certified and vetted by our team." },
                { icon: "🔒", title: "Secure & Confidential", desc: "Your conversations and data are encrypted and private." },
                { icon: "📱", title: "MoMo Payments", desc: "Pay conveniently with Mobile Money — MTN, Vodafone, AirtelTigo." },
              ].map((item) => (
                <div key={item.title} className="glass rounded-2xl p-6 text-center tilt-card">
                  <div className="text-4xl mb-3">{item.icon}</div>
                  <h3 className="text-lg font-bold mb-2">{item.title}</h3>
                  <p className="text-gray-400 text-sm">{item.desc}</p>
                </div>
              ))}
            </div>
          </AnimatedSection>
        </div>
      </section>

      {/* ═══ CTA ═══ */}
      <section className="py-24 relative overflow-hidden">
        <div className="absolute inset-0 bg-gradient-to-br from-[#1e3a5f] to-[#0a1628]" />
        <div className="absolute inset-0 dot-pattern opacity-50" />
        {/* Floating shapes */}
        <div className="absolute top-10 left-10 w-20 h-20 border border-[#d4a843]/20 rounded-lg animate-float-slow rotate-12" />
        <div className="absolute bottom-10 right-20 w-16 h-16 border border-blue-500/20 rounded-full animate-float" />
        <div className="absolute top-1/2 right-10 w-12 h-12 border border-[#d4a843]/10 rounded-lg animate-float-slow rotate-45" />

        <div className="max-w-3xl mx-auto px-4 text-center relative z-10">
          <AnimatedSection>
            <h2 className="text-3xl md:text-5xl font-bold mb-6">
              Ready to Get <span className="gradient-text">Legal Help?</span>
            </h2>
            <p className="text-gray-400 mb-10 max-w-lg mx-auto text-lg">
              Join thousands of Ghanaians who trust LawConnect GH for their legal needs.
            </p>
            <Link
              href="/auth/register"
              className="btn-shimmer inline-block bg-gradient-to-r from-[#d4a843] to-[#e0be6a] text-[#0a1628] px-10 py-4 rounded-full font-bold text-lg hover:shadow-[0_0_40px_rgba(212,168,67,0.4)] transition-all"
            >
              Create Free Account
            </Link>
          </AnimatedSection>
        </div>
      </section>
    </div>
  );
}
