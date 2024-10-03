import { useState } from 'react';
import { Bell, ChevronDown, LayoutDashboard, Menu, Settings, Users, Box, AlertCircle} from 'lucide-react';
import { Button } from "@/components/ui/button";
import Header from "@/components/Dashboard/Header";
import Inventory from "@/components/Dashboard/Inventory";
import DashboardPage from "@/components/Dashboard/DashboardPage";  // Renamed to match JSX
import Organizations from "@/components/Dashboard/Organizations";
import CreateEvent from "@/components/Dashboard/CreateEvent";
import ManageRequests from '@/components/Dashboard/ManageRequests';
import MyAlerts from '@/components/Dashboard/MyAlerts';
import logo from '../../assets/Logo.png';

export default function Dashboard() {
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const [activePage, setActivePage] = useState('dashboard'); // 'inventory' is set as active by default

  return (
    <div className="flex h-screen bg-gray-100">
      {/* Sidebar */}
      <aside className={`bg-[#063970] text-white backdrop-blur-xl w-64 min-h-screen p-4 ${sidebarOpen ? 'block' : 'hidden'} md:block`}>
        <div className="flex items-center justify-between mb-4 pr-4">
        <img src={logo} alt="NeedNest Logo" className="w-52 h-auto mb-4" /> {/* Adjust width and height as needed */}
        <Button variant="ghost" size="icon" className="md:hidden" onClick={() => setSidebarOpen(false)}>
            <Menu className="h-6 w-6" />
          </Button>
        </div>
        <nav>
        <Button
            variant="ghost"
            className={`w-full justify-start mb-2 text-xl ${activePage === 'dashboard' ? 'bg-gray-200 text-[#063970]' : 'text-white'}`}
            onClick={() => setActivePage('dashboard')}
        >
            <LayoutDashboard className="mr-2 h-4 w-4" />
            Dashboard
        </Button>
        <Button
            variant="ghost"
            className={`w-full justify-start mb-2 text-xl ${activePage === 'inventory' ? 'bg-gray-200 text-[#063970]' : 'text-white'}`}
            onClick={() => setActivePage('inventory')}
        >
            <Box className="mr-2 h-4 w-4" />
            Inventory
        </Button>
        <Button
            variant="ghost"
            className={`w-full justify-start mb-2 text-xl ${activePage === 'organizations' ? 'bg-gray-200 text-[#063970]' : 'text-white'}`}
            onClick={() => setActivePage('organizations')}
        >
            <Users className="mr-2 h-4 w-4" />
            Organizations
        </Button>
        <Button
            variant="ghost"
            className={`w-full justify-start mb-2 text-xl ${activePage === 'createEvent' ? 'bg-gray-200 text-[#063970]' : 'text-white'}`}
            onClick={() => setActivePage('createEvent')}
        >
            <AlertCircle className="mr-2 h-4 w-4" />
            Create Alert
        </Button>
        <Button
            variant="ghost"
            className={`w-full justify-start mb-2 text-xl ${activePage === 'myAlerts' ? 'bg-gray-200 text-[#063970]' : 'text-white'}`}
            onClick={() => setActivePage('myAlerts')}
        >
            <Settings className="mr-2 h-4 w-4" />
            My Alerts
        </Button>
        <Button
            variant="ghost"
            className={`w-full justify-start mb-2 text-xl ${activePage === 'manageRequests' ? 'bg-gray-200 text-[#063970]' : 'text-white'}`}
            onClick={() => setActivePage('manageRequests')}
        >
            <Bell className="mr-2 h-4 w-4" />
            Requests
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
        {activePage === 'manageRequests' && <ManageRequests />}
        {activePage === 'myAlerts' && <MyAlerts />}
      </div>
    </div>
  );
}
