import Link from "next/link";

export default function Footer() {
  return (
    <footer className="bg-[#060e1a] text-white border-t border-white/5">
      <div className="max-w-7xl mx-auto px-4 py-16 grid grid-cols-1 md:grid-cols-4 gap-10">
        <div>
          <h3 className="font-bold text-xl mb-4">
            <span className="gradient-text">⚖️ LawConnect</span>{" "}
            <span className="text-gray-500 font-light">GH</span>
          </h3>
          <p className="text-sm text-gray-500 leading-relaxed">
            Connecting Ghanaians with verified lawyers. Affordable, secure, and convenient legal help.
          </p>
        </div>
        <div>
          <h4 className="font-semibold mb-4 text-gray-300">Services</h4>
          <ul className="space-y-3 text-sm text-gray-500">
            <li><Link href="/lawyers" className="hover:text-[#d4a843] transition">Find a Lawyer</Link></li>
            <li><Link href="/consultations/new" className="hover:text-[#d4a843] transition">Start Consultation</Link></li>
            <li><Link href="/documents" className="hover:text-[#d4a843] transition">Generate Documents</Link></li>
            <li><Link href="/rights" className="hover:text-[#d4a843] transition">Know Your Rights</Link></li>
          </ul>
        </div>
        <div>
          <h4 className="font-semibold mb-4 text-gray-300">Legal Topics</h4>
          <ul className="space-y-3 text-sm text-gray-500">
            <li><Link href="/lawyers?topic=land-property" className="hover:text-[#d4a843] transition">Land & Property</Link></li>
            <li><Link href="/lawyers?topic=family-law" className="hover:text-[#d4a843] transition">Family Law</Link></li>
            <li><Link href="/lawyers?topic=criminal-law" className="hover:text-[#d4a843] transition">Criminal Law</Link></li>
            <li><Link href="/lawyers?topic=business-corporate" className="hover:text-[#d4a843] transition">Business & Corporate</Link></li>
          </ul>
        </div>
        <div>
          <h4 className="font-semibold mb-4 text-gray-300">Contact</h4>
          <ul className="space-y-3 text-sm text-gray-500">
            <li>📞 +233 30 000 0000</li>
            <li>✉️ support@lawconnect.gh</li>
            <li>📍 Accra, Ghana</li>
          </ul>
        </div>
      </div>
      <div className="border-t border-white/5">
        <div className="max-w-7xl mx-auto px-4 py-5 text-center text-sm text-gray-600">
          © {new Date().getFullYear()} LawConnect GH. All rights reserved.
        </div>
      </div>
    </footer>
  );
}
