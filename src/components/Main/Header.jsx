import React from 'react';
import { Button } from "@/components/ui/button";
import { useNavigate } from 'react-router-dom'; // Import useNavigate
import logo from '../../assets/Logo.png';

const Header = () => {
    const navigate = useNavigate(); // Initialize navigate

    // Function to handle the button click
    const handleSignUpClick = () => {
        navigate('/login'); // Navigate to the login page
    };

    return (
        <header className=" text-primary-foreground bg-opacity-60 backdrop-blur-md"> {/* Use a backdrop-blur for better effect */}
            <div className="container mx-auto px-4 pt-3 flex justify-between items-center">
            <img src={logo} alt="NeedNest Logo" className="w-52 h-auto mb-4" />
                <nav className="ml-96">
                    <ul className="flex space-x-4">
                        <li><a href="#" className="hover:underline">Home</a></li>
                        <li><a href="#" className="hover:underline">Opportunities</a></li>
                        <li><a href="#" className="hover:underline">About</a></li>
                        <li><a href="#" className="hover:underline">Contact</a></li>
                    </ul>
                </nav>
                {/* Attach the click event to navigate */}
                <Button onClick={handleSignUpClick} className="bg-white text-[#063970] hover:bg-gray-500">
                    Login
                </Button>
            </div>
        </header>
    );
};

export default Header;
