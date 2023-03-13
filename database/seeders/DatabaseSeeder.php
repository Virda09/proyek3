<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\User;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        

        User::factory()->create([
        'username' => 'Admin',
        'id_role' => '1',
        'nama' =>'admin',
        'password' => 'admin123'
        ]);
    }
}
