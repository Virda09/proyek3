<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Providers\RouteServiceProvider;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Http\Request;


class LoginController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    use AuthenticatesUsers;

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = RouteServiceProvider::HOME;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }

    public function login(Request $request)
    {
        try {
            $input = $request->all();
            $this->validate($request, [
                'username' => ['required', 'string', 'string', 'max:255'],
                'password' => ['required', 'string', 'min:8'],
            ]);

            if (auth()->attempt(array('username' => $input['username'], 'password' => $input['password'], 'role' => 'admin'))) {
                return redirect()->route('home');
            } else {
                Alert()->error('Login Gagal', 'Username atau Password Salah');
                return redirect()->route('login');
            }
        } catch (\Throwable $th) {
            $data['type'] = "521";
            $data['message'] = "Web Server is Down.";
            return response()->view('layouts.error',$data);
        }
    }
}
