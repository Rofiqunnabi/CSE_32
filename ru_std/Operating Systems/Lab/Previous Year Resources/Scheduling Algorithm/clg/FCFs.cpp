#include <iostream>
using namespace std;


struct Process {
    int id;
    int arrival;
    int burst;
    int completion;
    int turnaround;
    int waiting;
};

int main() {
    int n;
    float total_tat = 0, total_wt = 0;

    cout << "Enter number of processes: ";
    cin >> n;

    Process p[100];

    for (int i = 0; i < n; i++) {
        p[i].id = i + 1;
        cout << "Enter Arrival Time and Burst Time for Process P" << p[i].id << ": ";
        cin >> p[i].arrival >> p[i].burst;
    }


    Process temp;
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (p[j].arrival > p[j + 1].arrival) {
                temp = p[j];
                p[j] = p[j + 1];
                p[j + 1] = temp;
            }
        }
    }

    int current_time = 0;
    for (int i = 0; i < n; i++) {

        if (current_time < p[i].arrival) {
            current_time = p[i].arrival;
        }

        p[i].completion = current_time + p[i].burst;
        p[i].turnaround = p[i].completion - p[i].arrival;
        p[i].waiting = p[i].turnaround - p[i].burst;

        total_tat += p[i].turnaround;
        total_wt += p[i].waiting;


        current_time = p[i].completion;
    }


    cout << "\nProcess\tArrival\tBurst\tCompletion\tTurnaround\tWaiting\n";
    for (int i = 0; i < n; i++) {
        cout << "P" << p[i].id << "\t"
             << p[i].arrival << "\t"
             << p[i].burst << "\t"
             << p[i].completion << "\t\t"
             << p[i].turnaround << "\t\t"
             << p[i].waiting << "\n";
    }


    cout << "\nAverage Turnaround Time = " << total_tat / n << endl;
    cout << "Average Waiting Time = " << total_wt / n << endl;

    return 0;
}
