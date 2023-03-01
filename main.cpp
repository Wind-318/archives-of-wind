#include <drogon/drogon.h>

int main() {
    auto cookie_expired_time = drogon::app().getCustomConfig()["cookie_expires"].asInt();
    std::cout << cookie_expired_time << std::endl;
    drogon::app().loadConfigFile("./config/config.json").enableSession(cookie_expired_time).run();
    return 0;
}
