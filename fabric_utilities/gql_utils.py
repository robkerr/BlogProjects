# gql_utils.py
import pandas as pd
import sempy.fabric as fabric

def _table_payload_to_df(payload: dict) -> pd.DataFrame:
    result = payload.get("result", {})

    if result.get("kind") != "TABLE":
        raise ValueError(f"Expected TABLE result, got: {result.get('kind')}. Full payload: {payload}")

    cols = [c["name"] for c in result.get("columns", [])]
    df = pd.DataFrame(result.get("data", []))

    return df.reindex(columns=cols)

def run_gql_query(gql_query: str, graph_model_id: str, workspace_id: str | None = None) -> pd.DataFrame:
    client = fabric.FabricRestClient()  

    if workspace_id is None:
        workspace_id = fabric.get_workspace_id()

    url = f"/v1/workspaces/{workspace_id}/GraphModels/{graph_model_id}/executeQuery?preview=true"
    resp = client.post(url, json={"query": gql_query})

    if resp.status_code != 200:
        raise RuntimeError(f"HTTP {resp.status_code}: {resp.text}")

    payload = resp.json()

    status = payload.get("status", {})

    code = status.get("code", "")
    if not code.startswith(("00", "01", "02", "03")):
        raise RuntimeError(f"GQL status indicates error: {status}")

    return _table_payload_to_df(payload)