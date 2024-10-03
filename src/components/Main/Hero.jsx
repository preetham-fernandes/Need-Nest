import { Button } from "@/components/ui/button";


export default function Hero() {
  return (
    <section
      className="text-white h-[80vh] flex items-center justify-center">
      <div className="text-center px-4">  {/* Remove container class for centering */}
        <h1 className="text-6xl font-bold mb-4">Make a Difference Today</h1>
        <p className="text-xl mb-8">Join our community of volunteers and help create positive change in the world.</p>
        <Button size="lg">Join Us</Button>
      </div>
    </section>
    
  );
}
