#include <iostream>
#include <string>
#include <curl/curl.h>
#include "json.hpp"

using json = nlohmann::json;
using namespace std;

// Callback function for curl to write the response data
static size_t WriteCallback(void* contents, size_t size, size_t nmemb, void* userp) {
    ((string*)userp)->append((char*)contents, size * nmemb);
    return size * nmemb;
}

int main() {
    curl_global_init(CURL_GLOBAL_DEFAULT);

    string apiKey = "fill your api key";  // Replace with your API key from https://cricketdata.org/
    string url = "https://api.cricapi.com/v1/currentMatches?apikey=" + apiKey + "&offset=0";

    CURL* curl = curl_easy_init();
    if (!curl) {
        cerr << "Failed to initialize CURL\n";
        curl_global_cleanup();
        return 1;
    }

    string readBuffer;

    // Set curl options
    curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &readBuffer);
    curl_easy_setopt(curl, CURLOPT_USERAGENT, "Cricket-Live-Score/1.0");
    curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
    curl_easy_setopt(curl, CURLOPT_TIMEOUT, 30L);

    CURLcode res = curl_easy_perform(curl);

    long response_code;
    curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &response_code);

    curl_easy_cleanup(curl);
    curl_global_cleanup();

    if (res != CURLE_OK) {
        cerr << "cURL request failed: " << curl_easy_strerror(res) << "\n";
        return 1;
    }

    if (response_code != 200) {
        cerr << "HTTP Error: " << response_code << "\n";
        cerr << "Response: " << readBuffer << "\n";
        return 1;
    }

    if (readBuffer.empty()) {
        cerr << "Empty response from API\n";
        return 1;
    }

    try {
        auto j = json::parse(readBuffer);

        if (j.contains("status") && j["status"] == "failure") {
            cerr << "API Error: " << j.value("reason", "Unknown error") << "\n";
            return 1;
        }

        if (!j.contains("data")) {
            cerr << "Unexpected response format:\n" << readBuffer << "\n";
            return 1;
        }

        auto matches = j["data"];
        if (matches.empty()) {
            cout << "No live matches currently available.\n";
            return 0;
        }

        cout << "=== Live Cricket Matches ===\n\n";

        for (const auto& match : matches) {
            string team1 = "Unknown Team", team2 = "Unknown Team";

            if (match.contains("teams") && match["teams"].is_array()) {
                if (match["teams"].size() > 0) team1 = match["teams"][0].get<string>();
                if (match["teams"].size() > 1) team2 = match["teams"][1].get<string>();
            }

            string matchType = match.value("matchType", "");
            string status = match.value("status", "");

            cout << team1 << " vs " << team2;
            if (!matchType.empty()) {
                cout << " (" << matchType << ")";
            }
            cout << "\n";

            if (!status.empty()) {
                cout << "Status: " << status << "\n";
            }

            // Show score
            if (match.contains("score") && match["score"].is_array()) {
                for (const auto& score : match["score"]) {
                    if (score.contains("inning")) {
                        cout << score["inning"].get<string>() << ": ";
                        if (score.contains("r")) cout << score["r"].get<int>() << "/";
                        if (score.contains("w")) cout << score["w"].get<int>();
                        if (score.contains("o")) cout << " (" << score["o"].get<double>() << " overs)";
                        cout << "\n";
                    }
                }
            }

            cout << "---\n";
        }

    } catch (const json::parse_error& e) {
        cerr << "JSON parse error: " << e.what() << "\n";
        cerr << "Raw response: " << readBuffer << "\n";
        return 1;
    } catch (const exception& e) {
        cerr << "Error: " << e.what() << "\n";
        return 1;
    }

    return 0;
}
