export default function EmptyState({ icon = "📭", title = "Nothing here yet", message = "" }: { icon?: string; title?: string; message?: string }) {
  return (
    <div className="text-center py-16">
      <div className="text-5xl mb-4">{icon}</div>
      <h3 className="text-lg font-semibold text-gray-700">{title}</h3>
      {message && <p className="text-gray-500 mt-1">{message}</p>}
    </div>
  );
}
