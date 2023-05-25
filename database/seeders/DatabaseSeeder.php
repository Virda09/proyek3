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
        User::create([
            'nama' => 'Admin',
            'username' => 'admin',
            'password' => bcrypt('password'),
            'role' => 'admin',
        ]);

        User::create([
            'nama' => 'Koordinator',
            'username' => 'koordinator',
            'password' => bcrypt('password'),
            'role' => 'koordinator',
        ]);
    }
}
