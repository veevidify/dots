#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
This module will produce a ratio of running to all docker containers
"""

import docker
import sys

class Py3status:

    # template = '🐳 {version} Containers: {running}/{total} Images: {images} Swarm: {managers}/{nodes}'
    template = '🐳 {version} -  {running}/{total} -  {images}'
    template_down = '🐳'

    def __init__(self):
        self.client = docker.from_env()

    def docker_status(self):
        try:
            info = self._get_info()
        except Exception as e:
            return {
                'full_text': self.template_down,
                'cached_until': self.py3.time_in(1)
            }

        version = self._get_version(info)
        containers = self._get_container_info(info)
        images = self._get_images(info)
        # swarm = self._get_swarm()

        full_text = self.py3.safe_format(self.template, {
            'version': version,
            'running': containers.get('running', ""),
            'total': containers.get('total', ""),
            'images': images.get('images', ""),
                # managers=swarm.get("managers"),
                # nodes=swarm.get("nodes")
            })

        return {
            'full_text': full_text,
            'cached_until': self.py3.time_in(1)
        }

    def _get_info(self):
        try:
            info = self.client.info()
        except:
            info = {}
        return info

    def _get_container_info(self, info: dict):
        total_containers = info.get('Containers', "")
        running_containers = info.get('ContainersRunning', "")
        return {'running': running_containers, 'total': total_containers}


    def _get_version(self, info: dict):
        return info.get('ServerVersion', "")


    def _get_images(self, info: dict):
        return {'images': info.get('Images', "")}


    def _get_swarm(self, info: dict):
        try:
            if not bool(info["Swarm"]['Cluster']['ID']):
                return {}
        except KeyError:
            return {}
        return {"managers": info["Swarm"]["Managers"], "nodes": info["Swarm"]["Nodes"]}
