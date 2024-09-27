import { Card, CardHeader, CardTitle, CardDescription, CardContent } from "@/components/ui/card"
import { Button } from "@/components/ui/button"

const opportunities = [
  {
    title: "Community Garden",
    description: "Help maintain and grow our local community garden.",
    location: "City Park",
    date: "Every Saturday",
  },
  {
    title: "Food Bank Assistant",
    description: "Assist in sorting and distributing food to those in need.",
    location: "Downtown Food Bank",
    date: "Weekdays",
  },
  {
    title: "Senior Companion",
    description: "Provide companionship and assistance to seniors in our community.",
    location: "Various Locations",
    date: "Flexible Schedule",
  },
]

export default function VolunteerOpportunities() {
  return (
    <section className="py-20">
      <div className="container mx-auto px-4">
        <h2 className="text-3xl font-bold mb-8 text-center">Volunteer Opportunities</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {opportunities.map((opportunity, index) => (
            <Card key={index}>
              <CardHeader>
                <CardTitle>{opportunity.title}</CardTitle>
                <CardDescription>{opportunity.description}</CardDescription>
              </CardHeader>
              <CardContent>
                <p className="mb-2"><strong>Location:</strong> {opportunity.location}</p>
                <p className="mb-4"><strong>Date:</strong> {opportunity.date}</p>
                <Button>Sign Up</Button>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </section>
  )
}