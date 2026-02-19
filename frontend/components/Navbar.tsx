"use client";

import Link from "next/link";
import { useAuth } from "./AuthProvider";
import { useState } from "react";

export default function Navbar() {
  const { user, logout } = useAuth();
  const [open, setOpen] = useState(false);

  return (
    <nav className="bg-primary text-white sticky top-0 z-50">
      <div className="max-w-7xl mx-auto px-4 flex items-center justify-between h-16">
        <Link href="/" className="flex items-center gap-2 font-bold text-xl">
          <span className="text-accent">⚖️</span> LawConnect GH
        </Link>

        {/* Desktop */}
        <div className="hidden md:flex items-center gap-6 text-sm">
          <Link href="/lawyers" className="hover:text-accent transition">Find a Lawyer</Link>
          <Link href="/documents" className="hover:text-accent transition">Documents</Link>
          <Link href="/rights" className="hover:text-accent transition">Know Your Rights</Link>
          {user ? (
            <>
              <Link href="/dashboard" className="hover:text-accent transition">Dashboard</Link>
              {user.role === "Admin" && (
                <Link href="/admin" className="hover:text-accent transition">Admin</Link>
              )}
              <button onClick={logout} className="bg-accent text-primary px-4 py-2 rounded-full font-semibold hover:bg-accent-light transition">
                Logout
              </button>
            </>
          ) : (
            <>
              <Link href="/auth/login" className="hover:text-accent transition">Login</Link>
              <Link href="/auth/register" className="bg-accent text-primary px-4 py-2 rounded-full font-semibold hover:bg-accent-light transition">
                Register
              </Link>
            </>
          )}
        </div>

        {/* Mobile toggle */}
        <button className="md:hidden text-2xl" onClick={() => setOpen(!open)}>
          {open ? "✕" : "☰"}
        </button>
      </div>

      {/* Mobile menu */}
      {open && (
        <div className="md:hidden bg-primary-dark px-4 pb-4 space-y-3 text-sm">
          <Link href="/lawyers" className="block py-2 hover:text-accent" onClick={() => setOpen(false)}>Find a Lawyer</Link>
          <Link href="/documents" className="block py-2 hover:text-accent" onClick={() => setOpen(false)}>Documents</Link>
          <Link href="/rights" className="block py-2 hover:text-accent" onClick={() => setOpen(false)}>Know Your Rights</Link>
          {user ? (
            <>
              <Link href="/dashboard" className="block py-2 hover:text-accent" onClick={() => setOpen(false)}>Dashboard</Link>
              {user.role === "Admin" && (
                <Link href="/admin" className="block py-2 hover:text-accent" onClick={() => setOpen(false)}>Admin</Link>
              )}
              <button onClick={() => { logout(); setOpen(false); }} className="block w-full text-left py-2 text-accent">Logout</button>
            </>
          ) : (
            <>
              <Link href="/auth/login" className="block py-2 hover:text-accent" onClick={() => setOpen(false)}>Login</Link>
              <Link href="/auth/register" className="block py-2 text-accent font-semibold" onClick={() => setOpen(false)}>Register</Link>
            </>
          )}
        </div>
      )}
    </nav>
  );
}
