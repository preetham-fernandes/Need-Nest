import React, { useEffect, useState } from 'react';
import { db } from '../../firebase/Firebase';
import { collection, getDocs, addDoc, updateDoc, doc } from 'firebase/firestore';
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

const Inventory = () => {
  const [resources, setResources] = useState([]);
  const [inputValues, setInputValues] = useState({});
  const [modalOpen, setModalOpen] = useState(false); // State to manage modal visibility
  const [resourcesList, setResourcesList] = useState([ // State to track multiple resource inputs
    { category: '', description: '', name: '', quantityAvailable: 0, resourceId: 0 }
  ]);

  useEffect(() => {
    const fetchResources = async () => {
      const resourcesCollection = collection(db, "Resources");
      const resourceSnapshot = await getDocs(resourcesCollection);
      const resourceList = resourceSnapshot.docs.map(doc => ({
        id: doc.id,
        ...doc.data()
      }));
      setResources(resourceList);
    };

    fetchResources();
  }, []);

  // Function to update resource quantity in Firestore
const updateQuantity = async (id, amount) => {
  try {
    const resourceRef = doc(db, "Resources", id); // Get reference to the specific document
    const resourceDoc = await getDocs(resourceRef); // Get the current data
    const resourceData = resourceDoc.data();

    // Update the quantity by adding/subtracting the amount
    const newQuantity = resourceData.quantityAvailable + amount;

    // Ensure quantity doesn't go below 0
    const updatedQuantity = newQuantity < 0 ? 0 : newQuantity;

    // Update the resource in Firebase
    await updateDoc(resourceRef, { quantityAvailable: updatedQuantity });

    // Optionally update the local state to reflect changes without needing to refetch
    setResources(prevResources => 
      prevResources.map(resource =>
        resource.id === id
          ? { ...resource, quantityAvailable: updatedQuantity }
          : resource
      )
    );
  } catch (error) {
    console.error("Error updating resource quantity: ", error);
  }
};


  const handleInputChange = (id, value) => {
    setInputValues(prev => ({ ...prev, [id]: value }));
  };

  // const handleQuantityChange = (id, action) => {
  //   const resource = resources.find(resource => resource.id === id);
  //   const inputValue = parseInt(inputValues[id]) || 0;

  //   if (action === 'add') {
  //     updateQuantity(id, inputValue);
  //   } else if (action === 'subtract') {
  //     updateQuantity(id, -inputValue);
  //   }

  //   setInputValues(prev => ({ ...prev, [id]: '' }));
  // };
  const handleQuantityChange = async (id, action) => {
    try {
      const resource = resources.find(resource => resource.id === id);
      const inputValue = parseInt(inputValues[id]) || 0;
  
      // Get the document reference for the specific resource
      const resourceDocRef = doc(db, "Resources", id);
  
      if (action === 'add') {
        // Update the quantity by adding the input value
        await updateDoc(resourceDocRef, {
          quantityAvailable: resource.quantityAvailable + inputValue
        });
      } else if (action === 'subtract') {
        // Update the quantity by subtracting the input value
        await updateDoc(resourceDocRef, {
          quantityAvailable: resource.quantityAvailable - inputValue
        });
      }
  
      // Clear the input field after the update
      setInputValues(prev => ({ ...prev, [id]: '' }));
  
      // Fetch the updated list of resources to reflect changes in the UI
      const resourcesCollection = collection(db, "Resources");
      const resourceSnapshot = await getDocs(resourcesCollection);
      const resourceList = resourceSnapshot.docs.map(doc => ({
        id: doc.id,
        ...doc.data()
      }));
      setResources(resourceList);
    } catch (error) {
      console.error("Error updating resource quantity: ", error);
    }
  };
  
  

  const handleNewResourceChange = (index, e) => {
    const { name, value } = e.target;
    setResourcesList(prev =>
      prev.map((res, i) => (i === index ? { ...res, [name]: value } : res))
    );
  };

  const handleAddResourceRow = () => {
    setResourcesList(prev => [
      ...prev,
      { category: '', description: '', name: '', quantityAvailable: 0, resourceId: 0 }
    ]);
  };

  const handleRemoveResourceRow = (index) => {
    setResourcesList(prev => prev.filter((_, i) => i !== index));
  };

  const handleAddResources = async () => {
    try {
      for (const resource of resourcesList) {
        const { category, description, name, quantityAvailable, resourceId } = resource;
        await addDoc(collection(db, "Resources"), {
          category,
          description,
          name,
          quantityAvailable: parseInt(quantityAvailable),
          resourceId: parseInt(resourceId)
        });
      }

      setResourcesList([{ category: '', description: '', name: '', quantityAvailable: 0, resourceId: 0 }]);
      setModalOpen(false);
    } catch (error) {
      console.error("Error adding resources: ", error);
    }
  };

  return (
    <div>
      {/* Button to Open Modal */}
      <main className="flex-1 overflow-x-hidden overflow-y-auto bg-gray-100 p-4">
        <button
          onClick={() => setModalOpen(true)}
          className="mb-4 px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600"
        >
          Add Resources
        </button>

        {/* Modal for Adding Resources */}
        {modalOpen && (
          <div className="fixed inset-0 flex items-center justify-center bg-white bg-opacity-50 p-4">
            <div className="bg-white p-6 rounded shadow-lg max-w-xl w-full">
              <h2 className="text-lg font-semibold mb-4">Add New Resources</h2>

              {/* Dynamic Resource Fields */}
              {resourcesList.map((resource, index) => (
                <div key={index} className="mb-4">
                  <input
                    type="text"
                    name="name"
                    placeholder="Name"
                    value={resource.name}
                    onChange={(e) => handleNewResourceChange(index, e)}
                    className="mb-2 w-full border border-gray-300 rounded px-2"
                  />
                  <input
                    type="text"
                    name="category"
                    placeholder="Category"
                    value={resource.category}
                    onChange={(e) => handleNewResourceChange(index, e)}
                    className="mb-2 w-full border border-gray-300 rounded px-2"
                  />
                  <input
                    type="text"
                    name="description"
                    placeholder="Description"
                    value={resource.description}
                    onChange={(e) => handleNewResourceChange(index, e)}
                    className="mb-2 w-full border border-gray-300 rounded px-2"
                  />
                  <input
                    type="number"
                    name="quantityAvailable"
                    placeholder="Quantity Available"
                    value={resource.quantityAvailable}
                    onChange={(e) => handleNewResourceChange(index, e)}
                    className="mb-2 w-full border border-gray-300 rounded px-2"
                  />
                  <input
                    type="number"
                    name="resourceId"
                    placeholder="Resource ID"
                    value={resource.resourceId}
                    onChange={(e) => handleNewResourceChange(index, e)}
                    className="mb-2 w-full border border-gray-300 rounded px-2"
                  />

                  {/* Remove Button */}
                  {resourcesList.length > 1 && (
                    <button
                      onClick={() => handleRemoveResourceRow(index)}
                      className="bg-red-500 text-white rounded px-2 py-1 ml-2"
                    >
                      Remove
                    </button>
                  )}
                </div>
              ))}

              {/* Add More Resource Button */}
              <button
                onClick={handleAddResourceRow}
                className="mb-4 px-4 py-2 bg-gray-500 text-white rounded hover:bg-gray-600"
              >
                Add More Resource
              </button>

              <div className="flex justify-between mt-4">
                <button
                  onClick={handleAddResources}
                  className="px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600"
                >
                  Add All Resources
                </button>
                <button
                  onClick={() => setModalOpen(false)}
                  className="px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600"
                >
                  Cancel
                </button>
              </div>
            </div>
          </div>
        )}

        {/* Table for Managing Resources */}
        <div className="bg-white shadow-md rounded-lg overflow-hidden">
        <div className="max-h-[80vh] overflow-y-auto">
          <table className="min-w-full leading-normal">
            <thead>
              <tr>
                <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                  Resource Id
                </th>
                <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                  Name
                </th>
                <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                  Quantity
                </th>
                <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                  Category
                </th>
                <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                  Description
                </th>
                <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                  Actions
                </th>
              </tr>
            </thead>
            <tbody>
              {resources.map(resource => (
                <tr key={resource.id}>
                  <td className="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                    {resource.resourceId}
                  </td>
                  <td className="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                    {resource.name}
                  </td>
                  <td className="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                    {resource.quantityAvailable}
                  </td>
                  <td className="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                    {resource.category}
                  </td>
                  <td className="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                    {resource.description}
                  </td>
                  <td className="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                    <input
                      type="number"
                      value={inputValues[resource.id] || ''}
                      onChange={e => handleInputChange(resource.id, e.target.value)}
                      className="border rounded w-16 px-2 mr-2"
                    />
                    <button
                      onClick={() => handleQuantityChange(resource.id, 'add')}
                      className="bg-green-500 text-white rounded px-2 py-1"
                    >
                      Add
                    </button>
                    <button
                      onClick={() => handleQuantityChange(resource.id, 'subtract')}
                      className="bg-red-500 text-white rounded px-2 py-1 ml-2"
                    >
                      Subtract
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        </div>
      </main>
    </div>
  );
};

export default Inventory;
