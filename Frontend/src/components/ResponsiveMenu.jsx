import { X } from 'lucide-react'

const links = [
  ['About', '#about'],
  ['Experience', '#experience'],
  ['Projects', '#projects'],
  ['Education', '#education'],
  ['Contact', '#contact'],
]

export default function ResponsiveMenu({ open, onClose }) {
  if (!open) return null
  return (
    <div className="mobile-menu-backdrop" onClick={onClose}>
      <aside className="mobile-menu" onClick={(event) => event.stopPropagation()}>
        <div className="mobile-menu-head">
          <span className="brand">chirru<span>.</span></span>
          <button onClick={onClose} aria-label="Close menu"><X /></button>
        </div>
        <nav>
          {links.map(([label, href]) => <a key={href} href={href} onClick={onClose}>{label}</a>)}
        </nav>
      </aside>
    </div>
  )
}
