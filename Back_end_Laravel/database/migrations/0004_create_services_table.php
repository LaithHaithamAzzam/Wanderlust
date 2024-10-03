<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Models\Service;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('services', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->string('service');
            $table->foreignId('trip_id')->constrained()->references('trip_id')->onDelete('cascade');
        });
   

        /*$services = [
            ['name' => 'Accommodation', 'description' => 'Various types of accommodations provided during the trip.'],
            ['name' => 'Transportation', 'description' => 'Transport services including buses, cars, and flights.'],
            ['name' => 'Meals', 'description' => 'Includes breakfast, lunch, and dinner options.'],
            ['name' => 'Guided Tours', 'description' => 'Professional guides for tours and excursions.'],
            ['name' => 'Insurance', 'description' => 'Travel insurance covering health, accidents, and theft.'],
            ['name' => 'Tickets', 'description' => 'Tickets for museums, events, and attractions.'],
            ['name' => 'Equipment Rental', 'description' => 'Rental services for equipment like bikes, skis, etc.'],
            ['name' => 'Support', 'description' => '24/7 support services during the trip.'],
            ['name' => 'Local Experiences', 'description' => 'Unique local experiences like cooking classes, cultural tours, etc.'],
            ['name' => 'Airport Transfers', 'description' => 'Transfers to and from the airport.'],
            ['name' => 'Visa Assistance', 'description' => 'Help with obtaining visas for travel.'],
            ['name' => 'Emergency Assistance', 'description' => 'Assistance in case of emergencies.'],
            ['name' => 'Wellness Programs', 'description' => 'Programs focused on health and wellness.'],
            ['name' => 'Photography Services', 'description' => 'Professional photography services during the trip.'],
            ['name' => 'Wi-Fi Access', 'description' => 'Access to Wi-Fi throughout the trip.'],
            ['name' => 'Event Planning', 'description' => 'Planning and organizing events.'],
            ['name' => 'Childcare Services', 'description' => 'Services for taking care of children.'],
            ['name' => 'Pet Care Services', 'description' => 'Services for taking care of pets.'],
            ['name' => 'Spa Services', 'description' => 'Access to spa treatments and services.'],
            ['name' => 'Fitness Programs', 'description' => 'Programs focused on fitness and exercise.'],
            ['name' => 'Language Assistance', 'description' => 'Help with translation and language barriers.'],
            ['name' => 'Currency Exchange', 'description' => 'Services for exchanging currency.'],
            ['name' => 'Car Rental', 'description' => 'Rental services for cars.'],
            ['name' => 'Cultural Workshops', 'description' => 'Workshops focused on local culture and traditions.'],
            ['name' => 'Concert Tickets', 'description' => 'Tickets for concerts and live performances.'],
            ['name' => 'Medical Services', 'description' => 'Access to medical services and healthcare.'],
            ['name' => 'Special Needs Assistance', 'description' => 'Services for travelers with special needs.'],
            ['name' => 'Shopping Assistance', 'description' => 'Help with shopping and purchasing items.'],
            ['name' => 'Travel Consultation', 'description' => 'Consultation services for travel planning.'],
            ['name' => 'Baggage Handling', 'description' => 'Services for handling and managing baggage.'],
            ['name' => 'Local SIM Cards', 'description' => 'Provision of local SIM cards for communication.'],
            ['name' => 'Souvenir Packages', 'description' => 'Packages including local souvenirs and gifts.']
        ];
        
        Service::insert($services);*/
        
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('services');
    }
};
