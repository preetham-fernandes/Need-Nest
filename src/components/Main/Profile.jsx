import Header from "@/components/Main/Header";
import Hero from "@/components/Main/Hero";
import VolunteerOpportunities from "@/components/Main/VolunteerOpportunities";
import Footer from "@/components/Main/Footer";
import herobg from "../../assets/hero2.png";

export default function Profile() {
  return (
    <div className="min-h-screen flex flex-col">
      <div className="relative"
      style={{
        backgroundImage: `url(${herobg})`,
        backgroundSize: 'cover',
        backgroundPosition: 'center',
      }}
      >
        <Header />
        <Hero />
      </div>
      <main className="flex-grow">
        <VolunteerOpportunities />
      </main>
      <Footer />
    </div>
  );
}
