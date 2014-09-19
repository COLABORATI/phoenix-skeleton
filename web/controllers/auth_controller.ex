defmodule Hello2.AuthController do
    use Phoenix.Controller
    require Record
    Record.defrecord :credentials, [ username: "", password: ""]

    def index(conn, _params) do
        current_user = get_session( conn, :username )
        Logger.log(:debug, "current_user: " <> current_user )

        conn
        |> assign_layout(:none)
        |> render "index",
        %{
            login_action:     "/auth/login", #Hello2.Router.do_login_path,
            current_user:     current_user,
            is_authenticated: current_user != nil
        }
    end

    def do_login( conn, %{ "password" => password, "username" => username } ) do
        credentials = credentials( username: username, password: password )
        login_result = authenticate( credentials )
        conn = put_session( conn, :username, username )
        json conn, JSON.encode!( %{ success: login_result == :ok, reason: login_result } )
    end

    def do_login( conn, _ ) do
        json conn, JSON.encode!( %{ success: false, reason: "params must be username and password"  } )
    end

    def do_logout( conn, _params ) do
        current_user = get_session( conn, :username )
        logout_result = case current_user do
            nil -> :not_authenticated
            _   -> :ok
        end
        if :ok == logout_result do
            conn = put_session( conn, :username, nil )
        end
        json conn, JSON.encode!( %{ success: logout_result == :ok, reason: logout_result } )
    end

    def not_found(conn, _params) do
        render conn, "not_found"
    end

    def error(conn, _params) do
        render conn, "error"
    end

    def get_users do
        %{ "testuser": "testpass" }
    end

    def authenticate( {:credentials, str_username, password} ) do
        username = String.to_atom( str_username )
        users = get_users()
        case Map.has_key?( users, username) do
            true  -> if users[ username ] == to_string( password ) do :ok else :wrong end
            false -> :unknown
        end
    end

end
