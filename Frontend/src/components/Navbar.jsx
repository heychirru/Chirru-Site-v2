import { Menu } from 'lucide-react'

const links = [
  ['About', '#about'],
  ['Experience', '#experience'],
  ['Projects', '#projects'],
  ['Education', '#education'],
  ['Contact', '#contact'],
]

export default function Navbar({ onMenu }) {
  return (
    <header className="navbar">
      <a className="brand" href="#home">chirru<span>.</span></a>
      <nav className="desktop-nav" aria-label="Primary navigation">
        {links.map(([label, href]) => <a key={href} href={href}>{label}</a>)}
      </nav>
      <button className="menu-button" onClick={onMenu} aria-label="Open menu"><Menu size={22} /></button>
    </header>
  )
}
