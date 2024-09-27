import React from 'react'

export default function Footer() {
    return (
      <footer className="bg-[#0d6efd] text-primary-foreground py-8">
        <div className="container mx-auto px-4 text-center">
          <p>&copy; 2023 VolunteerHub. All rights reserved.</p>
          <div className="mt-4">
            <a href="#" className="hover:underline mr-4">Privacy Policy</a>
            <a href="#" className="hover:underline mr-4">Terms of Service</a>
            <a href="#" className="hover:underline">Contact Us</a>
          </div>
        </div>
      </footer>
    )
  }