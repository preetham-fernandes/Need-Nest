import React from 'react';
import { Bell, ChevronDown, Menu } from 'lucide-react';
import { Input } from "@/components/ui/input";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { auth } from '../../firebase/Firebase'; // import the auth object from your Firebase configuration
import { signOut } from "firebase/auth"; // import the signOut method

const Header = () => {
  
  const handleLogout = async () => {
    try {
      await signOut(auth); // Call signOut to log out the user
      console.log("User logged out successfully");
      // You can also redirect the user to the login page after logout
      window.location.href = "/profile"; // Adjust the redirection path as per your routing
    } catch (error) {
      console.error("Error logging out: ", error);
    }
  };

  return (
    <div>
      {/* Header */}
      <header className="bg-white shadow-md p-4">
        <div className="flex items-center justify-end">
          <Button variant="ghost" size="icon" className="md:hidden" onClick={() => setSidebarOpen(true)}>
            <Menu className="h-6 w-6" />
          </Button>
          <div className="flex items-center">
            {/* Search bar, bell icon, and dropdown */}
            <Input
              type="search"
              placeholder="Search..."
              className="mr-2"
            />
            <Button size="icon" variant="ghost">
              <Bell className="h-5 w-5" />
            </Button>
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="ghost" className="ml-2">
                  <Avatar className="h-8 w-8">
                    <AvatarImage src="/placeholder.svg?height=32&width=32" alt="@johndoe" />
                    <AvatarFallback>PF</AvatarFallback>
                  </Avatar>
                  <ChevronDown className="ml-2 h-4 w-4" />
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end">
                <DropdownMenuLabel>My Account</DropdownMenuLabel>
                <DropdownMenuSeparator />
                <DropdownMenuItem>Profile</DropdownMenuItem>
                <DropdownMenuItem>Settings</DropdownMenuItem>
                <DropdownMenuItem onClick={handleLogout}>Logout</DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          </div>
        </div>
      </header>
    </div>
  );
};

export default Header;
