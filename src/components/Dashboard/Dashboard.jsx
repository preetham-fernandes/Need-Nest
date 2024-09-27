import { useState } from 'react';
import { Bell, ChevronDown, LayoutDashboard, Menu, Settings, Users, Box, AlertCircle} from 'lucide-react';
import { Button } from "@/components/ui/button";
import Header from "@/components/Dashboard/Header";
import Inventory from "@/components/Dashboard/Inventory";
import DashboardPage from "@/components/Dashboard/DashboardPage";  // Renamed to match JSX
import Organizations from "@/components/Dashboard/Organizations";
import CreateEvent from "@/components/Dashboard/CreateEvent";

export default function Dashboard() {
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const [activePage, setActivePage] = useState('inventory'); // 'inventory' is set as active by default

  return (
    <div className="flex h-screen bg-gray-100">
      {/* Sidebar */}
      <aside className={`bg-white w-64 min-h-screen p-4 ${sidebarOpen ? 'block' : 'hidden'} md:block`}>
        <div className="flex items-center justify-between mb-4 pr-4">
          <h2 className="text-xl font-bold">Voluntrack</h2>
          <Button variant="ghost" size="icon" className="md:hidden" onClick={() => setSidebarOpen(false)}>
            <Menu className="h-6 w-6" />
          </Button>
        </div>
        <nav>
          <Button
            variant="ghost"
            className={`w-full justify-start mb-2 ${activePage === 'dashboard' ? 'bg-gray-200' : ''}`}
            onClick={() => setActivePage('dashboard')}
          >
            <LayoutDashboard className="mr-2 h-4 w-4" />
            Dashboard
          </Button>
          <Button
            variant="ghost"
            className={`w-full justify-start mb-2 ${activePage === 'inventory' ? 'bg-gray-200' : ''}`}
            onClick={() => setActivePage('inventory')}
          >
            <Box className="mr-2 h-4 w-4" />
            Inventory
          </Button>
          <Button
            variant="ghost"
            className={`w-full justify-start mb-2 ${activePage === 'organizations' ? 'bg-gray-200' : ''}`}  // Corrected the condition to 'organizations'
            onClick={() => setActivePage('organizations')}
          >
            <Users className="mr-2 h-4 w-4" />
            Organizations
          </Button>
          <Button
            variant="ghost"
            className={`w-full justify-start mb-2 ${activePage === 'createEvent' ? 'bg-gray-200' : ''}`}  // Corrected the condition to 'createEvent'
            onClick={() => setActivePage('createEvent')}
          >
            <AlertCircle className="mr-2 h-4 w-4" />
            Create Alert
          </Button>
        </nav>
      </aside>

      {/* Main Content */}
      <div className="flex-1 flex flex-col overflow-hidden">
        <Header />
        {activePage === 'inventory' && <Inventory />}
        {activePage === 'dashboard' && <DashboardPage />}
        {activePage === 'organizations' && <Organizations />}
        {activePage === 'createEvent' && <CreateEvent />}
        {/* You can add other components for different pages similarly */}
      </div>
    </div>
  );
}
