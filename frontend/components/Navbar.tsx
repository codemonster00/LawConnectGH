"use client";

import Link from "next/link";
import { useAuth } from "./AuthProvider";
import { useState, useEffect } from "react";

export default function Navbar() {
  const { user, logout } = useAuth();
  const [open, setOpen] = useState(false);
  const [scrolled, setScrolled] = useState(false);

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 20);
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  return (
    <nav className={`fixed top-0 left-0 right-0 z-50 transition-all duration-300 ${
      scrolled ? "bg-[#0a1628]/95 backdrop-blur-xl shadow-lg shadow-black/20 border-b border-white/5" : "bg-transparent"
    }`}>
      <div className="max-w-7xl mx-auto px-4 flex items-center justify-between h-16">
        <Link href="/" className="flex items-center gap-2 font-bold text-xl text-white">
          <span className="gradient-text text-2xl">⚖️</span> 
          <span className="gradient-text">LawConnect</span>
          <span className="text-gray-400 font-light">GH</span>
        </Link>

        {/* Desktop */}
        <div className="hidden md:flex items-center gap-6 text-sm">
          <Link href="/lawyers" className="text-gray-300 hover:text-[#d4a843] transition">Find a Lawyer</Link>
          <Link href="/documents" className="text-gray-300 hover:text-[#d4a843] transition">Documents</Link>
          <Link href="/rights" className="text-gray-300 hover:text-[#d4a843] transition">Know Your Rights</Link>
          {user ? (
            <>
              <Link href="/dashboard" className="text-gray-300 hover:text-[#d4a843] transition">Dashboard</Link>
              {user.role === "Admin" && (
                <Link href="/admin" className="text-gray-300 hover:text-[#d4a843] transition">Admin</Link>
              )}
              <button onClick={logout} className="btn-shimmer bg-gradient-to-r from-[#d4a843] to-[#e0be6a] text-[#0a1628] px-5 py-2 rounded-full font-semibold hover:shadow-[0_0_20px_rgba(212,168,67,0.3)] transition-all">
                Logout
              </button>
            </>
          ) : (
            <>
              <Link href="/auth/login" className="text-gray-300 hover:text-[#d4a843] transition">Login</Link>
              <Link href="/auth/register" className="btn-shimmer bg-gradient-to-r from-[#d4a843] to-[#e0be6a] text-[#0a1628] px-5 py-2 rounded-full font-semibold hover:shadow-[0_0_20px_rgba(212,168,67,0.3)] transition-all">
                Register
              </Link>
            </>
          )}
        </div>

        {/* Mobile toggle */}
        <button className="md:hidden text-2xl text-white" onClick={() => setOpen(!open)}>
          {open ? "✕" : "☰"}
        </button>
      </div>

      {/* Mobile menu */}
      <div className={`md:hidden transition-all duration-300 overflow-hidden ${open ? "max-h-96 opacity-100" : "max-h-0 opacity-0"}`}>
        <div className="glass-strong mx-4 mb-4 rounded-2xl p-4 space-y-3 text-sm">
          <Link href="/lawyers" className="block py-2 text-gray-300 hover:text-[#d4a843]" onClick={() => setOpen(false)}>Find a Lawyer</Link>
          <Link href="/documents" className="block py-2 text-gray-300 hover:text-[#d4a843]" onClick={() => setOpen(false)}>Documents</Link>
          <Link href="/rights" className="block py-2 text-gray-300 hover:text-[#d4a843]" onClick={() => setOpen(false)}>Know Your Rights</Link>
          {user ? (
            <>
              <Link href="/dashboard" className="block py-2 text-gray-300 hover:text-[#d4a843]" onClick={() => setOpen(false)}>Dashboard</Link>
              {user.role === "Admin" && (
                <Link href="/admin" className="block py-2 text-gray-300 hover:text-[#d4a843]" onClick={() => setOpen(false)}>Admin</Link>
              )}
              <button onClick={() => { logout(); setOpen(false); }} className="block w-full text-left py-2 text-[#d4a843]">Logout</button>
            </>
          ) : (
            <>
              <Link href="/auth/login" className="block py-2 text-gray-300 hover:text-[#d4a843]" onClick={() => setOpen(false)}>Login</Link>
              <Link href="/auth/register" className="block py-2 text-[#d4a843] font-semibold" onClick={() => setOpen(false)}>Register</Link>
            </>
          )}
        </div>
      </div>
    </nav>
  );
}
