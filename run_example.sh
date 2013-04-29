curl -XGET http://localhost:8080/instagram_media/efficient_map/_search -d '{
  "query": {
    "bool": {
      "must": [],
      "must_not": [],
      "should": [
        {
          "query_string": {
            "default_field": "text",
            "query": "starbucks"
          }
        }
      ]
    }
  },
  "from": 0,
  "size": 5000,
  "sort": [],
  "facets": {}
}' > insta_starbuck_5000.json
