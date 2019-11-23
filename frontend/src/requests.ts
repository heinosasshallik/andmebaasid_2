import {URL} from "@/constants";

export default async function getRequest(url: string) {
    return await fetch(URL + url, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        },
    })
}