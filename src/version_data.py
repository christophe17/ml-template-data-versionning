from typing import Any, List, Optional, Tuple

import hydra
import pyrootutils
from omegaconf import DictConfig


from src.utils.data_utils import initialize_dvc, initialize_dvc_storage, make_new_data_version



root = pyrootutils.setup_root(
    search_from=__file__,
    indicator=[".git", "pyproject.toml"],
    pythonpath=True,
    dotenv=True,
)
_HYDRA_PARAMS = {
    "version_base": "1.3",
    "config_path": str(root / "configs"),
    "config_name": "default.yaml",
}

@hydra.main(**_HYDRA_PARAMS)
def main(cfg: DictConfig) -> Optional[float]:

    initialize_dvc()

    # initialize_dvc_storage(config.dvc_remote_name, config.dvc_remote_url)

    # make_new_data_version(config.dvc_raw_data_folder, config.dvc_remote_name)


if __name__ == "__main__":
    main()
