import {URL} from "@/constants";

export async function getRequest(url: string) {
    return await fetch(URL + url, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        },
    })
}

export async function putRequest(url: string, body: any) {
    return await fetch(URL + url, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(body)
    })
}
