import React from 'react';
import { Button } from "@/components/ui/button";
import { useNavigate } from 'react-router-dom'; // Import useNavigate

const Header = () => {
    const navigate = useNavigate(); // Initialize navigate

    // Function to handle the button click
    const handleSignUpClick = () => {
        navigate('/login'); // Navigate to the login page
    };

    return (
        <header className="bg-opacity-60 text-primary-foreground backdrop-blur-md"> {/* Use a backdrop-blur for better effect */}
            <div className="container mx-auto px-4 py-6 flex justify-between items-center">
                <h1 className="text-2xl font-bold">Voluntrack</h1>
                <nav className="ml-96">
                    <ul className="flex space-x-4">
                        <li><a href="#" className="hover:underline">Home</a></li>
                        <li><a href="#" className="hover:underline">Opportunities</a></li>
                        <li><a href="#" className="hover:underline">About</a></li>
                        <li><a href="#" className="hover:underline">Contact</a></li>
                    </ul>
                </nav>
                {/* Attach the click event to navigate */}
                <Button onClick={handleSignUpClick} className="bg-white text-primary hover:bg-gray-500">
                    Login
                </Button>
            </div>
        </header>
    );
};

export default Header;
