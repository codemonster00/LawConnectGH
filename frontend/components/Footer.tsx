import Link from "next/link";

export default function Footer() {
  return (
    <footer className="bg-primary text-white mt-auto">
      <div className="max-w-7xl mx-auto px-4 py-12 grid grid-cols-1 md:grid-cols-4 gap-8">
        <div>
          <h3 className="font-bold text-lg mb-3">
            <span className="text-accent">⚖️</span> LawConnect GH
          </h3>
          <p className="text-sm text-gray-300">
            Connecting Ghanaians with verified lawyers. Affordable, secure, and convenient legal help.
          </p>
        </div>
        <div>
          <h4 className="font-semibold mb-3">Services</h4>
          <ul className="space-y-2 text-sm text-gray-300">
            <li><Link href="/lawyers" className="hover:text-accent">Find a Lawyer</Link></li>
            <li><Link href="/consultations/new" className="hover:text-accent">Start Consultation</Link></li>
            <li><Link href="/documents" className="hover:text-accent">Generate Documents</Link></li>
            <li><Link href="/rights" className="hover:text-accent">Know Your Rights</Link></li>
          </ul>
        </div>
        <div>
          <h4 className="font-semibold mb-3">Legal Topics</h4>
          <ul className="space-y-2 text-sm text-gray-300">
            <li><Link href="/lawyers?topic=land-property" className="hover:text-accent">Land & Property</Link></li>
            <li><Link href="/lawyers?topic=family-law" className="hover:text-accent">Family Law</Link></li>
            <li><Link href="/lawyers?topic=criminal-law" className="hover:text-accent">Criminal Law</Link></li>
            <li><Link href="/lawyers?topic=business-corporate" className="hover:text-accent">Business & Corporate</Link></li>
          </ul>
        </div>
        <div>
          <h4 className="font-semibold mb-3">Contact</h4>
          <ul className="space-y-2 text-sm text-gray-300">
            <li>📞 +233 30 000 0000</li>
            <li>✉️ support@lawconnect.gh</li>
            <li>📍 Accra, Ghana</li>
          </ul>
        </div>
      </div>
      <div className="border-t border-primary-light">
        <div className="max-w-7xl mx-auto px-4 py-4 text-center text-sm text-gray-400">
          © {new Date().getFullYear()} LawConnect GH. All rights reserved.
        </div>
      </div>
    </footer>
  );
}
