'use client'

import React, { useState } from 'react';
import { collection, addDoc } from 'firebase/firestore';
import { db } from '../../firebase/Firebase';
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { toast } from "@/components/hooks/use-toast";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Label } from "@/components/ui/label";

export default function AlertForm() {
  const [alertData, setAlertData] = useState({
    title: '',
    description: '',
    compensation: '',
    contactPersonName: '',
    contactPersonPhone: '',
    dateTime: '',
    duration: '',
    location: '',
    postedBy: '',
    resourcesNeeded: '',
    skillsRequired: '',
    status: 'open',
    urgencyLevel: 'medium',
    volunteersNeeded: ''
  });

  const handleChange = (e) => {
    setAlertData({
      ...alertData,
      [e.target.name]: e.target.value
    });
  };

  const handleSelectChange = (name, value) => {
    setAlertData({
      ...alertData,
      [name]: value
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    // Convert comma-separated strings to arrays
    const resourcesNeededArray = alertData.resourcesNeeded.split(',').map(item => item.trim());
    const skillsRequiredArray = alertData.skillsRequired.split(',').map(skill => skill.trim());

    try {
      // Add document to Firestore collection
      await addDoc(collection(db, 'Alerts'), {
        ...alertData,
        resourcesNeeded: resourcesNeededArray,
        skillsRequired: skillsRequiredArray,
        volunteersNeeded: parseInt(alertData.volunteersNeeded),
        contactPerson: {
          name: alertData.contactPersonName,
          phone: parseInt(alertData.contactPersonPhone),
        },
        dateTime: new Date(alertData.dateTime), // Ensure dateTime is a Date object
        status: 'open',
      });

      // Show success toast
      toast({
        title: 'Success',
        description: 'Alert added successfully!',
      });

      // Optionally, reset the form after submission
      setAlertData({
        title: '',
        description: '',
        compensation: '',
        contactPersonName: '',
        contactPersonPhone: '',
        dateTime: '',
        duration: '',
        location: '',
        postedBy: '',
        resourcesNeeded: '',
        skillsRequired: '',
        status: 'open',
        urgencyLevel: 'medium',
        volunteersNeeded: ''
      });

    } catch (error) {
      console.error('Error adding alert: ', error);

      // Show error toast
      toast({
        title: 'Error',
        description: 'Failed to add alert. Please try again.',
        variant: 'destructive',
      });
    }
  };

  return (
    <div className="container max-w-full p-4 overflow-auto max-h-[90vh]">
      <Card className="w-full">
        <CardHeader>
          <CardTitle className="text-3xl font-bold text-center">Create New Alert</CardTitle>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-6">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6 ">
              <div className="space-y-4">
                {/* Input fields */}
                <div>
                  <Label htmlFor="title" className="text-xl font-medium text-gray-700">Title</Label>
                  <Input id="title" name="title" value={alertData.title} onChange={handleChange} required className="mt-1 w-full border-2 border-gray-300 rounded-lg focus:border-blue-500 focus:outline-none" />
                </div>

                <div>
                  <Label htmlFor="description" className="text-xl font-medium text-gray-700">Description</Label>
                  <Textarea id="description" name="description" value={alertData.description} onChange={handleChange} required className="mt-1 w-full min-h-[100px] border-2 border-gray-300 rounded-lg focus:border-blue-500 focus:outline-none" />
                </div>

                <div>
                  <Label htmlFor="compensation" className="text-xl font-medium text-gray-700">Compensation (comma-separated)</Label>
                  <Input id="compensation" name="compensation" value={alertData.compensation} onChange={handleChange} className="mt-1 w-full border-2 border-gray-300 rounded-lg focus:border-blue-500 focus:outline-none" />
                </div>

                <div>
                  <Label htmlFor="contactPersonName" className="text-xl font-medium text-gray-700">Contact Person Name</Label>
                  <Input id="contactPersonName" name="contactPersonName" value={alertData.contactPersonName} onChange={handleChange} required className="mt-1 w-full border-2 border-gray-300 rounded-lg focus:border-blue-500 focus:outline-none" />
                </div>

                <div>
                  <Label htmlFor="contactPersonPhone" className="text-xl font-medium text-gray-700">Contact Person Phone</Label>
                  <Input id="contactPersonPhone" name="contactPersonPhone" type="tel" value={alertData.contactPersonPhone} onChange={handleChange} required className="mt-1 w-full border-2 border-gray-300 rounded-lg focus:border-blue-500 focus:outline-none" />
                </div>
              </div>

              <div className="space-y-4">
                <div>
                  <Label htmlFor="dateTime" className="text-xl font-medium text-gray-700">Date and Time</Label>
                  <Input id="dateTime" name="dateTime" type="datetime-local" value={alertData.dateTime} onChange={handleChange} required className="justify-end mt-1 w-full border-2 border-gray-300 rounded-lg focus:border-blue-500 focus:outline-none" />
                </div>

                <div>
                  <Label htmlFor="duration" className="text-xl font-medium text-gray-700">Duration (in hours)</Label>
                  <Input id="duration" name="duration" type="number" value={alertData.duration} onChange={handleChange} required className="mt-1 w-full border-2 border-gray-300 rounded-lg focus:border-blue-500 focus:outline-none" />
                </div>

                <div>
                  <Label htmlFor="location" className="text-xl font-medium text-gray-700">Location</Label>
                  <Input id="location" name="location" value={alertData.location} onChange={handleChange} required className="mt-1 w-full border-2 border-gray-300 rounded-lg focus:border-blue-500 focus:outline-none" />
                </div>

                <div>
                  <Label htmlFor="postedBy" className="text-xl font-medium text-gray-700">Posted By (userId)</Label>
                  <Input id="postedBy" name="postedBy" value={alertData.postedBy} onChange={handleChange} required className="mt-1 w-full border-2 border-gray-300 rounded-lg focus:border-blue-500 focus:outline-none" />
                </div>

                <div>
                  <Label htmlFor="resourcesNeeded" className="text-xl font-medium text-gray-700">Resources Needed (comma-separated)</Label>
                  <Input id="resourcesNeeded" name="resourcesNeeded" value={alertData.resourcesNeeded} onChange={handleChange} className="mt-1 w-full border-2 border-gray-300 rounded-lg focus:border-blue-500 focus:outline-none" />
                </div>
              </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <Label htmlFor="skillsRequired" className="text-xl font-medium text-gray-700">Skills Required (comma-separated)</Label>
                <Input id="skillsRequired" name="skillsRequired" value={alertData.skillsRequired} onChange={handleChange} className="mt-1 w-full border-2 border-gray-300 rounded-lg focus:border-blue-500 focus:outline-none" />
              </div>

              <div>
                <Label htmlFor="urgencyLevel" className="text-left text-xl font-medium text-gray-700">Urgency Level</Label>
                <Select name="urgencyLevel" value={alertData.urgencyLevel} onValueChange={(value) => handleSelectChange("urgencyLevel", value)}>
                  <SelectTrigger className="w-full mt-1 border-2 border-gray-300 rounded-lg focus:border-blue-500 focus:outline-none">
                    <SelectValue placeholder="Select urgency level" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="low">Low</SelectItem>
                    <SelectItem value="medium">Medium</SelectItem>
                    <SelectItem value="high">High</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>

            <div className="flex justify-end">
              <Button type="submit" className="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Create Alert</Button>
            </div>
          </form>
        </CardContent>
      </Card>
    </div>
  );
}
